#!/bin/bash

# ============================================
# LAYOUT ANATOMY ANALYZER — MAIN PROCESSOR
# ============================================
# Processes all images in input/ directory
# Generates SVG wireframes, MD specs, HTML prototypes
# ============================================

set -euo pipefail

# Configuration
INPUT_DIR="./input"
OUTPUT_DIR="./output"
SHARED_DIR="./shared"
VERBOSE=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --verbose|-v)
            VERBOSE=true
            shift
            ;;
        --input|-i)
            INPUT_DIR="$2"
            shift 2
            ;;
        --output|-o)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        --help|-h)
            echo "Layout Anatomy Analyzer"
            echo ""
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -i, --input DIR     Input directory (default: ./input)"
            echo "  -o, --output DIR    Output directory (default: ./output)"
            echo "  -v, --verbose       Verbose output"
            echo "  -h, --help          Show this help"
            echo ""
            echo "Supported formats: PNG, JPG, JPEG, WEBP"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Logging function
log() {
    if [ "$VERBOSE" = true ]; then
        echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"
    fi
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Validate directories
if [ ! -d "$INPUT_DIR" ]; then
    error "Input directory '$INPUT_DIR' does not exist"
    exit 1
fi

if [ ! -d "$OUTPUT_DIR" ]; then
    log "Creating output directory: $OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
fi

if [ ! -d "$SHARED_DIR" ]; then
    error "Shared directory '$SHARED_DIR' does not exist"
    exit 1
fi

# Find all image files
log "Scanning for images in $INPUT_DIR"
IMAGE_FILES=()
while IFS= read -r -d '' file; do
    IMAGE_FILES+=("$file")
done < <(find "$INPUT_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) -print0)

if [ ${#IMAGE_FILES[@]} -eq 0 ]; then
    warn "No image files found in $INPUT_DIR"
    echo "Supported formats: PNG, JPG, JPEG, WEBP"
    exit 0
fi

echo "Found ${#IMAGE_FILES[@]} image(s) to process"

# Process each image
PROCESSED=0
ERRORS=0

for image_file in "${IMAGE_FILES[@]}"; do
    # Extract filename without path and extension
    filename=$(basename "$image_file")
    name="${filename%.*}"
    
    echo ""
    echo "Processing: $filename"
    log "Image: $image_file"
    log "Name: $name"
    
    # Create output directory for this image
    image_output_dir="$OUTPUT_DIR/$name"
    mkdir -p "$image_output_dir"
    
    # Call single image processor
    if ./analyze-single.sh "$image_file" "$image_output_dir" "$name" 2>&1; then
        success "Generated outputs for $name"
        
        # Verify outputs were created
        svg_file="$image_output_dir/${name}_wireframe.svg"
        md_file="$image_output_dir/${name}_specification.md"
        html_file="$image_output_dir/${name}_layout.html"
        
        missing_files=()
        [ ! -f "$svg_file" ] && missing_files+=("SVG wireframe")
        [ ! -f "$md_file" ] && missing_files+=("MD specification")
        [ ! -f "$html_file" ] && missing_files+=("HTML prototype")
        
        if [ ${#missing_files[@]} -gt 0 ]; then
            warn "Missing files for $name: ${missing_files[*]}"
            ((ERRORS++))
        else
            log "All outputs verified for $name"
            ((PROCESSED++))
        fi
    else
        error "Failed to process $name"
        ((ERRORS++))
    fi
done

# Summary
echo ""
echo "============================================"
echo "PROCESSING SUMMARY"
echo "============================================"
echo "Images processed successfully: $PROCESSED"
echo "Errors encountered: $ERRORS"
echo "Total images: ${#IMAGE_FILES[@]}"

if [ $ERRORS -eq 0 ]; then
    success "All images processed successfully!"
    exit 0
else
    error "$ERRORS image(s) failed to process"
    exit 1
fi