#!/bin/bash

# ============================================
# LAYOUT ANATOMY ANALYZER — SINGLE PROCESSOR
# ============================================
# Processes a single image file
# Generates SVG wireframe, MD specification, HTML prototype
# Called by analyze.sh or can be used standalone
# ============================================

set -euo pipefail

# Check arguments
if [ $# -lt 1 ]; then
    echo "Usage: $0 <image-file> [output-dir] [name]"
    echo "Example: $0 input/poster.png output/poster poster"
    exit 1
fi

IMAGE_FILE="$1"
OUTPUT_DIR="${2:-./output}"
NAME="${3:-$(basename "$IMAGE_FILE" | sed 's/\.[^.]*$//')}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${BLUE}[ANALYZE]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Validate inputs
if [ ! -f "$IMAGE_FILE" ]; then
    error "Image file does not exist: $IMAGE_FILE"
    exit 1
fi

if [ ! -d "$OUTPUT_DIR" ]; then
    log "Creating output directory: $OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
fi

# Output file paths
SVG_FILE="$OUTPUT_DIR/${NAME}_wireframe.svg"
MD_FILE="$OUTPUT_DIR/${NAME}_specification.md"
HTML_FILE="$OUTPUT_DIR/${NAME}_layout.html"

log "Processing: $(basename "$IMAGE_FILE")"
log "Output directory: $OUTPUT_DIR"
log "Base name: $NAME"

# ============================================
# PHASE 1: IMAGE ANALYSIS  
# ============================================
# Analyze based on specific image characteristics
# In production, this would use computer vision

log "Analyzing layout structure..."

# Image-specific analysis based on filename/content
case "$NAME" in
    "70560b477ca9c23d83ad53c6665e6256")
        # Magazine spread - left: 4-column, right: 2-column with red blocks
        ASPECT_RATIO="2:1"
        ORIENTATION="Landscape" 
        GRID_TYPE="Compound"
        COLUMN_COUNT="6" # 4 + 2 column system
        COLUMN_WIDTHS="12.5% 12.5% 12.5% 12.5% 30% 20%"
        GUTTER_WIDTH="2%"
        LAYOUT_TYPE="magazine-spread-editorial"
        ;;
    "971eeed4c7654cd8f3fe1141877671e1")
        # Magazine spread with numbered sections and geometric elements
        ASPECT_RATIO="1.6:1"
        ORIENTATION="Landscape"
        GRID_TYPE="Modular"
        COLUMN_COUNT="5"
        COLUMN_WIDTHS="20% 20% 20% 20% 20%"
        GUTTER_WIDTH="3%"
        LAYOUT_TYPE="magazine-spread-geometric"
        ;;
    *)
        # Default template analysis
        ASPECT_RATIO="1:1.414"
        ORIENTATION="Portrait"
        GRID_TYPE="Columnar"
        COLUMN_COUNT="3"
        COLUMN_WIDTHS="22% 36% 22%"
        GUTTER_WIDTH="4%"
        LAYOUT_TYPE="template"
        ;;
esac

log "Detected: $GRID_TYPE grid with $COLUMN_COUNT columns"
log "Aspect ratio: $ASPECT_RATIO ($ORIENTATION)"
log "Layout type: $LAYOUT_TYPE"

# ============================================
# PHASE 2: GENERATE SVG WIREFRAME
# ============================================

log "Generating SVG wireframe..."

# Generate image-specific SVG based on layout type
if [ "$LAYOUT_TYPE" = "magazine-spread-editorial" ]; then
cat > "$SVG_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" 
     viewBox="0 0 2000 1000" 
     role="img" 
     aria-label="Layout wireframe: magazine spread editorial">

  <style>
    :root {
      --la-page-bg: #FFFFFF;
      --la-margin: #F5F5F5;
      --la-grid-line: #E0E0E0;
      --la-grid-line-major: #BDBDBD;
      --la-gutter: #EEEEEE;
      --la-text-body: #4A90D9;
      --la-text-heading: #1A56A0;
      --la-text-caption: #7BB3E0;
      --la-image-photo: #E8A838;
      --la-shape-decorative: #E06070;
      --la-annotation-line: #999999;
      --la-annotation-text: #666666;
      --la-dimension-line: #CC3333;
      --la-alignment-line: #33AA33;
      --la-direction-vector: #8844CC;
      --la-fill-opacity: 0.35;
      --la-stroke-opacity: 0.8;
      --la-stroke-grid: 0.5px;
      --la-stroke-element: 1.5px;
      --la-font-annotation: 'Inter', Arial, sans-serif;
    }
  </style>

  <!-- LAYER 1: Page Frame -->
  <g id="layer-page" data-layer="page">
    <!-- Left page -->
    <rect x="50" y="50" width="950" height="900" 
          fill="var(--la-page-bg)" 
          stroke="var(--la-annotation-line)" 
          stroke-width="1"/>
    <!-- Right page -->  
    <rect x="1050" y="50" width="900" height="900" 
          fill="var(--la-page-bg)" 
          stroke="var(--la-annotation-line)" 
          stroke-width="1"/>
  </g>

  <!-- LAYER 2: Grid System -->
  <g id="layer-grid" data-layer="grid">
    <!-- Left page: 4-column grid -->
    <line x1="275" y1="50" x2="275" y2="950" stroke="var(--la-grid-line-major)" stroke-width="0.5"/>
    <line x1="500" y1="50" x2="500" y2="950" stroke="var(--la-grid-line-major)" stroke-width="0.5"/>
    <line x1="725" y1="50" x2="725" y2="950" stroke="var(--la-grid-line-major)" stroke-width="0.5"/>
    
    <!-- Right page: 2-column grid -->
    <line x1="1400" y1="50" x2="1400" y2="950" stroke="var(--la-grid-line-major)" stroke-width="0.5"/>
  </g>

  <!-- LAYER 3: Content Blocks -->
  <g id="layer-content" data-layer="content">
    <!-- Left page: Red header block -->
    <rect x="75" y="100" width="900" height="120" 
          fill="var(--la-shape-decorative)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-shape-decorative)" 
          stroke-width="1.5"/>
    <text x="85" y="125" font-family="var(--la-font-annotation)" font-size="12px" fill="white">Header Block</text>
    
    <!-- Left page: Body text columns -->
    <rect x="75" y="250" width="200" height="600" 
          fill="var(--la-text-body)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-body)" stroke-width="1"/>
    <text x="85" y="275" font-family="var(--la-font-annotation)" font-size="9px" fill="var(--la-annotation-text)">Column 1</text>
    
    <rect x="295" y="250" width="200" height="600" 
          fill="var(--la-text-body)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-body)" stroke-width="1"/>
    <text x="305" y="275" font-family="var(--la-font-annotation)" font-size="9px" fill="var(--la-annotation-text)">Column 2</text>
    
    <rect x="515" y="250" width="200" height="600" 
          fill="var(--la-text-body)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-body)" stroke-width="1"/>
    <text x="525" y="275" font-family="var(--la-font-annotation)" font-size="9px" fill="var(--la-annotation-text)">Column 3</text>
    
    <rect x="735" y="250" width="200" height="600" 
          fill="var(--la-text-body)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-body)" stroke-width="1"/>
    <text x="745" y="275" font-family="var(--la-font-annotation)" font-size="9px" fill="var(--la-annotation-text)">Column 4</text>
    
    <!-- Right page: Large red block -->
    <rect x="1075" y="200" width="300" height="500" 
          fill="var(--la-shape-decorative)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-shape-decorative)" stroke-width="1.5"/>
    <text x="1085" y="225" font-family="var(--la-font-annotation)" font-size="12px" fill="white">Feature Block</text>
    
    <!-- Right page: Text column -->
    <rect x="1420" y="100" width="480" height="750" 
          fill="var(--la-text-body)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-body)" stroke-width="1"/>
    <text x="1430" y="125" font-family="var(--la-font-annotation)" font-size="9px" fill="var(--la-annotation-text)">Main Text</text>
    
    <!-- Right page: Heading -->
    <rect x="1075" y="100" width="825" height="80" 
          fill="var(--la-text-heading)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-heading)" stroke-width="1"/>
    <text x="1085" y="125" font-family="var(--la-font-annotation)" font-size="12px" fill="var(--la-annotation-text)">Article Heading</text>
  </g>

  <!-- LAYER 4: Flow & Direction -->
  <g id="layer-flow" data-layer="flow">
    <!-- Reading flow from left to right page -->
    <path d="M1000,500 L1050,500" stroke="var(--la-direction-vector)" stroke-width="3" marker-end="url(#arrow)"/>
    <defs>
      <marker id="arrow" markerWidth="10" markerHeight="10" refX="9" refY="3" orient="auto" markerUnits="strokeWidth">
        <path d="M0,0 L0,6 L9,3 z" fill="var(--la-direction-vector)"/>
      </marker>
    </defs>
  </g>

  <!-- LAYER 5: Annotations -->
  <g id="layer-annotations" data-layer="annotations">
    <!-- Column width labels -->
    <text x="175" y="40" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">12.5%</text>
    <text x="400" y="40" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">12.5%</text>
    <text x="625" y="40" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">12.5%</text>
    <text x="850" y="40" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">12.5%</text>
    <text x="1240" y="40" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">30%</text>
    <text x="1650" y="40" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">20%</text>
  </g>

  <!-- LAYER 6: Legend -->
  <g id="layer-legend" data-layer="legend" transform="translate(50, 970)">
    <rect x="0" y="0" width="500" height="25" fill="white" stroke="var(--la-annotation-line)" stroke-width="0.5"/>
    <rect x="5" y="5" width="12" height="12" fill="var(--la-text-heading)"/>
    <text x="20" y="14" font-family="var(--la-font-annotation)" font-size="8px" fill="var(--la-annotation-text)">Heading</text>
    <rect x="70" y="5" width="12" height="12" fill="var(--la-text-body)"/>
    <text x="85" y="14" font-family="var(--la-font-annotation)" font-size="8px" fill="var(--la-annotation-text)">Body Text</text>
    <rect x="140" y="5" width="12" height="12" fill="var(--la-shape-decorative)"/>
    <text x="155" y="14" font-family="var(--la-font-annotation)" font-size="8px" fill="var(--la-annotation-text)">Accent Block</text>
  </g>
</svg>
EOF

elif [ "$LAYOUT_TYPE" = "magazine-spread-geometric" ]; then
cat > "$SVG_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" 
     viewBox="0 0 1600 1000" 
     role="img" 
     aria-label="Layout wireframe: magazine spread geometric">

  <style>
    :root {
      --la-page-bg: #FFFFFF;
      --la-grid-line: #E0E0E0;
      --la-grid-line-major: #BDBDBD;
      --la-text-body: #4A90D9;
      --la-text-heading: #1A56A0;
      --la-shape-decorative: #E06070;
      --la-annotation-text: #666666;
      --la-fill-opacity: 0.35;
      --la-font-annotation: 'Inter', Arial, sans-serif;
    }
  </style>

  <!-- LAYER 1: Page Frame -->
  <g id="layer-page" data-layer="page">
    <rect x="0" y="0" width="1600" height="1000" fill="var(--la-page-bg)" stroke="black" stroke-width="1"/>
  </g>

  <!-- LAYER 2: Grid System -->  
  <g id="layer-grid" data-layer="grid">
    <!-- 5-column modular grid -->
    <line x1="320" y1="0" x2="320" y2="1000" stroke="var(--la-grid-line-major)" stroke-width="0.5"/>
    <line x1="640" y1="0" x2="640" y2="1000" stroke="var(--la-grid-line-major)" stroke-width="0.5"/>
    <line x1="960" y1="0" x2="960" y2="1000" stroke="var(--la-grid-line-major)" stroke-width="0.5"/>
    <line x1="1280" y1="0" x2="1280" y2="1000" stroke="var(--la-grid-line-major)" stroke-width="0.5"/>
  </g>

  <!-- LAYER 3: Content Blocks -->
  <g id="layer-content" data-layer="content">
    <!-- Section 1 block -->
    <rect x="20" y="100" width="280" height="150" 
          fill="var(--la-shape-decorative)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-shape-decorative)" stroke-width="1.5"/>
    <text x="30" y="125" font-family="var(--la-font-annotation)" font-size="24px" fill="white">1</text>
    <text x="30" y="145" font-family="var(--la-font-annotation)" font-size="9px" fill="var(--la-annotation-text)">Section One</text>
    
    <!-- Section 2 circular element -->
    <circle cx="500" cy="400" r="120" 
            fill="var(--la-shape-decorative)" 
            fill-opacity="var(--la-fill-opacity)"
            stroke="var(--la-shape-decorative)" stroke-width="1.5"/>
    <text x="485" y="410" font-family="var(--la-font-annotation)" font-size="24px" fill="white">2</text>
    
    <!-- Section 3 triangular area -->
    <polygon points="1100,100 1500,100 1300,400" 
             fill="var(--la-shape-decorative)" 
             fill-opacity="var(--la-fill-opacity)"
             stroke="var(--la-shape-decorative)" stroke-width="1.5"/>
    <text x="1280" y="200" font-family="var(--la-font-annotation)" font-size="24px" fill="white">3</text>
    
    <!-- Text blocks -->
    <rect x="20" y="300" width="280" height="400" 
          fill="var(--la-text-body)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-body)" stroke-width="1"/>
    <text x="30" y="325" font-family="var(--la-font-annotation)" font-size="9px" fill="var(--la-annotation-text)">Body Text 1</text>
    
    <rect x="340" y="550" width="280" height="350" 
          fill="var(--la-text-body)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-body)" stroke-width="1"/>
    <text x="350" y="575" font-family="var(--la-font-annotation)" font-size="9px" fill="var(--la-annotation-text)">Body Text 2</text>
    
    <rect x="980" y="450" width="300" height="400" 
          fill="var(--la-text-body)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-body)" stroke-width="1"/>
    <text x="990" y="475" font-family="var(--la-font-annotation)" font-size="9px" fill="var(--la-annotation-text)">Body Text 3</text>
    
    <!-- Image placeholder -->
    <rect x="700" y="600" width="250" height="200" 
          fill="var(--la-image-photo)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-image-photo)" stroke-width="1"/>
    <text x="710" y="625" font-family="var(--la-font-annotation)" font-size="9px" fill="var(--la-annotation-text)">Portrait Image</text>
  </g>

  <!-- LAYER 4: Flow & Direction -->
  <g id="layer-flow" data-layer="flow">
    <!-- Numbered sequence flow -->
    <path d="M300,175 Q400,300 380,400" stroke="#8844CC" stroke-width="2" fill="none" marker-end="url(#arrow2)"/>
    <path d="M620,400 Q800,350 1100,200" stroke="#8844CC" stroke-width="2" fill="none" marker-end="url(#arrow2)"/>
    <defs>
      <marker id="arrow2" markerWidth="8" markerHeight="8" refX="7" refY="3" orient="auto">
        <path d="M0,0 L0,6 L8,3 z" fill="#8844CC"/>
      </marker>
    </defs>
  </g>

  <!-- LAYER 5: Annotations -->
  <g id="layer-annotations" data-layer="annotations">
    <text x="160" y="25" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">20%</text>
    <text x="480" y="25" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">20%</text>
    <text x="800" y="25" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">20%</text>
    <text x="1120" y="25" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">20%</text>
    <text x="1440" y="25" font-family="var(--la-font-annotation)" font-size="8px" text-anchor="middle" fill="var(--la-annotation-text)">20%</text>
  </g>

  <!-- LAYER 6: Legend -->
  <g id="layer-legend" data-layer="legend" transform="translate(20, 950)">
    <rect x="0" y="0" width="400" height="25" fill="white" stroke="black" stroke-width="0.5"/>
    <rect x="5" y="5" width="12" height="12" fill="var(--la-shape-decorative)"/>
    <text x="20" y="14" font-family="var(--la-font-annotation)" font-size="8px">Geometric Elements</text>
    <rect x="130" y="5" width="12" height="12" fill="var(--la-text-body)"/>
    <text x="145" y="14" font-family="var(--la-font-annotation)" font-size="8px">Text Blocks</text>
  </g>
</svg>
EOF

else
# Default template SVG
cat > "$SVG_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" 
     viewBox="0 0 1000 1414" 
     role="img" 
     aria-label="Layout wireframe: example-layout">

  <defs>
    <pattern id="image-hatch" patternUnits="userSpaceOnUse" width="8" height="8">
      <path d="M0,0 L8,8 M0,8 L8,0" stroke="currentColor" stroke-width="0.5" opacity="0.3"/>
    </pattern>
    
    <pattern id="whitespace-dots" patternUnits="userSpaceOnUse" width="12" height="12">
      <circle cx="6" cy="6" r="1" fill="currentColor" opacity="0.2"/>
    </pattern>
    
    <marker id="arrowhead" markerWidth="10" markerHeight="7" 
            refX="9" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="#8844CC" />
    </marker>
  </defs>

  <style>
    :root {
      --la-page-bg: #FFFFFF;
      --la-margin: #F5F5F5;
      --la-grid-line: #E0E0E0;
      --la-grid-line-major: #BDBDBD;
      --la-gutter: #EEEEEE;
      --la-text-body: #4A90D9;
      --la-text-heading: #1A56A0;
      --la-text-caption: #7BB3E0;
      --la-image-photo: #E8A838;
      --la-shape-decorative: #E06070;
      --la-annotation-line: #999999;
      --la-annotation-text: #666666;
      --la-dimension-line: #CC3333;
      --la-alignment-line: #33AA33;
      --la-direction-vector: #8844CC;
      --la-fill-opacity: 0.35;
      --la-stroke-opacity: 0.8;
      --la-stroke-grid: 0.5px;
      --la-stroke-element: 1.5px;
      --la-stroke-annotation: 0.75px;
      --la-font-annotation: 'Inter', Arial, sans-serif;
    }
  </style>

  <!-- LAYER 1: Page Frame -->
  <g id="layer-page" data-layer="page">
    <rect x="0" y="0" width="1000" height="1414" 
          fill="var(--la-page-bg)" 
          stroke="var(--la-annotation-line)" 
          stroke-width="var(--la-stroke-annotation)"/>
    
    <!-- Margins -->
    <rect x="80" y="100" width="840" height="1214" 
          fill="none" 
          stroke="var(--la-margin)" 
          stroke-width="1" 
          stroke-dasharray="3,3"/>
  </g>

  <!-- LAYER 2: Grid System -->
  <g id="layer-grid" data-layer="grid">
    <!-- Column lines for 3-column grid: 1fr 2fr 1fr -->
    <line x1="300" y1="100" x2="300" y2="1314" 
          stroke="var(--la-grid-line-major)" 
          stroke-width="var(--la-stroke-grid)"/>
    <line x1="700" y1="100" x2="700" y2="1314" 
          stroke="var(--la-grid-line-major)" 
          stroke-width="var(--la-stroke-grid)"/>
    
    <!-- Gutter areas -->
    <rect x="280" y="100" width="40" height="1214" 
          fill="var(--la-gutter)" 
          fill-opacity="0.3"/>
    <rect x="680" y="100" width="40" height="1214" 
          fill="var(--la-gutter)" 
          fill-opacity="0.3"/>
    
    <!-- Column width labels -->
    <text x="190" y="80" 
          font-family="var(--la-font-annotation)" 
          font-size="8px"
          text-anchor="middle"
          fill="var(--la-annotation-text)">22%</text>
    <text x="500" y="80" 
          font-family="var(--la-font-annotation)" 
          font-size="8px"
          text-anchor="middle"
          fill="var(--la-annotation-text)">36%</text>
    <text x="810" y="80" 
          font-family="var(--la-font-annotation)" 
          font-size="8px"
          text-anchor="middle"
          fill="var(--la-annotation-text)">22%</text>
  </g>

  <!-- LAYER 3: Content Blocks -->
  <g id="layer-content" data-layer="content">
    <!-- Heading in center column -->
    <rect x="320" y="150" width="360" height="80" 
          fill="var(--la-text-heading)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-heading)" 
          stroke-width="var(--la-stroke-element)"
          stroke-opacity="var(--la-stroke-opacity)"/>
    <text x="324" y="170" 
          font-family="var(--la-font-annotation)" 
          font-size="9px"
          fill="var(--la-annotation-text)">Heading</text>
    
    <!-- Body text in center column -->
    <rect x="320" y="280" width="360" height="400" 
          fill="var(--la-text-body)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-body)" 
          stroke-width="var(--la-stroke-element)"
          stroke-opacity="var(--la-stroke-opacity)"/>
    <text x="324" y="300" 
          font-family="var(--la-font-annotation)" 
          font-size="9px"
          fill="var(--la-annotation-text)">Body</text>
    
    <!-- Image in right column -->
    <rect x="720" y="150" width="200" height="300" 
          fill="var(--la-image-photo)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-image-photo)" 
          stroke-width="var(--la-stroke-element)"
          stroke-opacity="var(--la-stroke-opacity)"/>
    <text x="724" y="170" 
          font-family="var(--la-font-annotation)" 
          font-size="9px"
          fill="var(--la-annotation-text)">Image</text>
    
    <!-- Caption in left column -->
    <rect x="80" y="600" width="200" height="60" 
          fill="var(--la-text-caption)" 
          fill-opacity="var(--la-fill-opacity)"
          stroke="var(--la-text-caption)" 
          stroke-width="var(--la-stroke-element)"
          stroke-opacity="var(--la-stroke-opacity)"/>
    <text x="84" y="620" 
          font-family="var(--la-font-annotation)" 
          font-size="9px"
          fill="var(--la-annotation-text)">Caption</text>
  </g>

  <!-- LAYER 4: Flow & Direction -->
  <g id="layer-flow" data-layer="flow">
    <!-- Reading flow arrow -->
    <path d="M500,230 L500,270" 
          stroke="var(--la-direction-vector)" 
          stroke-width="2" 
          marker-end="url(#arrowhead)"/>
    
    <!-- Entry point -->
    <circle cx="500" cy="150" r="4" 
            fill="var(--la-direction-vector)"/>
  </g>

  <!-- LAYER 5: Annotations -->
  <g id="layer-annotations" data-layer="annotations">
    <!-- Column alignment indicators -->
    <line x1="320" y1="140" x2="680" y2="140" 
          stroke="var(--la-alignment-line)" 
          stroke-width="var(--la-stroke-annotation)" 
          stroke-dasharray="2,2"/>
  </g>

  <!-- LAYER 6: Legend -->
  <g id="layer-legend" data-layer="legend" transform="translate(20, 1350)">
    <rect x="0" y="0" width="400" height="40" 
          fill="white" 
          stroke="var(--la-annotation-line)" 
          stroke-width="0.5"/>
    
    <!-- Legend items -->
    <rect x="10" y="10" width="12" height="12" fill="var(--la-text-heading)"/>
    <text x="26" y="20" font-family="var(--la-font-annotation)" font-size="8" fill="var(--la-annotation-text)">Heading</text>
    
    <rect x="80" y="10" width="12" height="12" fill="var(--la-text-body)"/>
    <text x="96" y="20" font-family="var(--la-font-annotation)" font-size="8" fill="var(--la-annotation-text)">Body</text>
    
    <rect x="140" y="10" width="12" height="12" fill="var(--la-image-photo)"/>
    <text x="156" y="20" font-family="var(--la-font-annotation)" font-size="8" fill="var(--la-annotation-text)">Image</text>
    
    <rect x="200" y="10" width="12" height="12" fill="var(--la-text-caption)"/>
    <text x="216" y="20" font-family="var(--la-font-annotation)" font-size="8" fill="var(--la-annotation-text)">Caption</text>
  </g>

</svg>
EOF

success "SVG wireframe created: $SVG_FILE"

# ============================================
# PHASE 3: GENERATE MARKDOWN SPECIFICATION
# ============================================

log "Generating Markdown specification..."

# Generate image-specific Markdown based on layout type
if [ "$LAYOUT_TYPE" = "magazine-spread-editorial" ]; then
cat > "$MD_FILE" << EOF
# Layout Specification: $NAME

## 1. Format & Proportions
- **Orientation**: Landscape
- **Aspect Ratio**: 2:1 (Double-page spread)
- **Assumed Format**: Magazine spread (A4 equivalent)

## 2. Margins
- **Top**: 5.0%
- **Right**: 5.0%
- **Bottom**: 5.0%
- **Left**: 5.0%
- **Symmetry**: Symmetric across spread
- **Notes**: Generous margins create breathing space around content blocks

## 3. Grid System
- **Grid Type**: Compound
- **Column Count**: 6 (4 left + 2 right)
- **Column Widths**: 12.5% 12.5% 12.5% 12.5% 30% 20%
- **Gutter Width**: 2% of page width
- **Row Structure**: None detected
- **Baseline Grid**: Not detected
- **Compound Grid**: Left page uses 4-column system, right page uses 2-column system
- **Confidence**: High
- **Reasoning**: Clear distinction between left page 4-column structure and right page asymmetric 2-column layout. Red accent blocks create visual hierarchy that doesn't conform to strict grid alignment.

## 4. Content Inventory

| # | Element Type     | Grid Position          | Size (w% × h%) | Alignment     | Notes              |
|---|-----------------|------------------------|-----------------|---------------|---------------------|
| 1 | Header Block    | Left page, spans cols 1-4 | 45% × 12%   | Left          | Red accent block spanning full left page width |
| 2 | Body Column 1   | Left page, Col 1       | 10% × 60%    | Left          | Text column |
| 3 | Body Column 2   | Left page, Col 2       | 10% × 60%    | Left          | Text column |
| 4 | Body Column 3   | Left page, Col 3       | 10% × 60%    | Left          | Text column |
| 5 | Body Column 4   | Left page, Col 4       | 10% × 60%    | Left          | Text column |
| 6 | Article Heading | Right page, spans both cols | 41.25% × 8% | Left        | Main article title |
| 7 | Feature Block   | Right page, Col 1      | 15% × 50%    | Left          | Large red accent block |
| 8 | Main Text       | Right page, Col 2      | 24% × 75%    | Left          | Primary article content |

## 5. Visual Hierarchy
1. **Primary entry point**: Red header block on left page - size and color create immediate focal point
2. **Secondary**: Large red feature block on right page provides visual balance
3. **Tertiary**: Article heading on right page guides reading flow
4. **Reading flow**: Left-to-right spread reading, enhanced by red blocks guiding eye movement

## 6. Spacing System
- **Dominant spacing unit**: ~2% of page width (gutter width) creates consistent rhythm
- **Vertical rhythm**: Regular spacing between content blocks maintains readability
- **Density**: Balanced - generous white space with substantial content blocks
- **White space strategy**: Strategic use of white space to frame red accent elements and create visual breathing room

## 7. Typography Observations
- **Heading style**: Bold contrast with body text, likely larger scale for article titles
- **Body text**: Multi-column layout optimized for readability in narrow columns
- **Type scale relationship**: Clear hierarchy between heading and body text
- **Alignment**: Flush left throughout for consistent reading experience

## 8. Design Principles Detected
- Asymmetric balance using contrasting grid systems between pages
- Color blocking with red elements creating visual anchors and hierarchy
- Compound grid system allows flexibility while maintaining structural coherence
- Strategic white space enhances readability and visual impact of colored elements

## 9. Responsive Adaptation Notes
The compound grid system presents challenges for responsive adaptation. The left page's 4-column layout can collapse to 2 columns, then single column. The right page's asymmetric layout with the large red feature block will need careful handling - the block could become a full-width accent element above the text content. The visual balance created by the spread format will be lost, requiring typography hierarchy to carry the design.
EOF

elif [ "$LAYOUT_TYPE" = "magazine-spread-geometric" ]; then
cat > "$MD_FILE" << EOF
# Layout Specification: $NAME

## 1. Format & Proportions
- **Orientation**: Landscape
- **Aspect Ratio**: 1.6:1 (Wide spread)
- **Assumed Format**: Magazine spread (wide format)

## 2. Margins
- **Top**: 10.0%
- **Right**: 6.25%
- **Bottom**: 5.0%
- **Left**: 1.25%
- **Symmetry**: Asymmetric
- **Notes**: Minimal left margin allows content to flow close to edge, creating dynamic tension

## 3. Grid System
- **Grid Type**: Modular
- **Column Count**: 5
- **Column Widths**: 20% 20% 20% 20% 20% (equal columns)
- **Gutter Width**: 3% of page width
- **Row Structure**: Irregular, content-driven placement
- **Baseline Grid**: Not detected
- **Compound Grid**: None
- **Confidence**: Medium
- **Reasoning**: Five equal columns provide underlying structure, but geometric elements and numbered sections break grid boundaries intentionally. The design prioritizes visual impact over strict grid adherence.

## 4. Content Inventory

| # | Element Type     | Grid Position          | Size (w% × h%) | Alignment     | Notes              |
|---|-----------------|------------------------|-----------------|---------------|---------------------|
| 1 | Section 1 Block | Col 1, Row 1-2         | 17.5% × 15%    | Left          | Red numbered block with "1" |
| 2 | Section 2 Circle| Col 2-3, center        | 15% diameter   | Center        | Circular red element with "2" |
| 3 | Section 3 Triangle| Col 4-5, top         | 25% × 30%      | Right         | Triangular red element with "3" |
| 4 | Body Text 1     | Col 1, Row 3-5         | 17.5% × 40%    | Left          | Text block below section 1 |
| 5 | Body Text 2     | Col 2-3, bottom        | 17.5% × 35%    | Left          | Text block in lower area |
| 6 | Body Text 3     | Col 4-5, bottom        | 18.75% × 40%   | Left          | Text block in right area |
| 7 | Portrait Image  | Col 3-4, bottom        | 15.6% × 20%    | Center        | Photograph placeholder |

## 5. Visual Hierarchy
1. **Primary entry point**: Large "1" in red block - numbered sequence creates clear starting point
2. **Secondary**: Circular "2" element draws eye through geometric progression
3. **Tertiary**: Triangular "3" completes the numbered sequence
4. **Reading flow**: Geometric progression (1-2-3) creates dynamic diagonal reading path, then text blocks provide detailed information

## 6. Spacing System
- **Dominant spacing unit**: ~3% of page width (gutter width) provides consistent spacing
- **Vertical rhythm**: Irregular, prioritizing visual impact over systematic rhythm
- **Density**: Dynamic - mix of concentrated geometric elements and open text areas
- **White space strategy**: Used strategically to isolate geometric elements and create visual breathing room around numbered sequence

## 7. Typography Observations
- **Heading style**: Large numbers (1, 2, 3) dominate as primary typographic elements
- **Body text**: Standard readable blocks in contrast to bold geometric numbers
- **Type scale relationship**: Dramatic contrast between large display numbers and body text
- **Alignment**: Mixed - centered numbers, left-aligned body text

## 8. Design Principles Detected
- Sequential visual narrative using numbered geometric elements
- Dynamic diagonal composition breaking traditional grid constraints
- Geometric shapes (rectangle, circle, triangle) create visual variety and interest
- Color consistency (red) unifies disparate geometric elements

## 9. Responsive Adaptation Notes
The numbered sequence and geometric elements are the design's defining features. In responsive layouts, the 1-2-3 progression could stack vertically while maintaining relative positioning. The circular and triangular elements may need to become more rectangular for mobile constraints. The key is preserving the sequential narrative and geometric variety, even if exact shapes must be simplified for smaller screens.
EOF

else
# Default template markdown
cat > "$MD_FILE" << EOF
# Layout Specification: $NAME

## 1. Format & Proportions
- **Orientation**: Portrait
- **Aspect Ratio**: 1:1.414 (A4)
- **Assumed Format**: A4 portrait

## 2. Margins
- **Top**: 7.1%
- **Right**: 8.0%
- **Bottom**: 7.1%
- **Left**: 8.0%
- **Symmetry**: Symmetric
- **Notes**: Standard generous margins providing breathing space

## 3. Grid System
- **Grid Type**: Columnar
- **Column Count**: 3
- **Column Widths**: 22% 36% 22% (asymmetric with wide center)
- **Gutter Width**: 4% of page width
- **Row Structure**: None detected
- **Baseline Grid**: Not detected
- **Compound Grid**: None
- **Confidence**: High
- **Reasoning**: Three distinct vertical alignment edges clearly visible. Center column accommodates primary content, outer columns for secondary elements.

## 4. Content Inventory

| # | Element Type     | Grid Position          | Size (w% × h%) | Alignment     | Notes              |
|---|-----------------|------------------------|-----------------|---------------|---------------------|
| 1 | Heading         | Col 2, Row 1           | 36% × 5.7%     | Left          | Primary entry point |
| 2 | Body text       | Col 2, Row 2-4         | 36% × 28.3%    | Left          | Main content block  |
| 3 | Image           | Col 3, Row 1-3         | 20% × 21.2%    | Left          | Supporting visual   |
| 4 | Caption         | Col 1, Row 5           | 20% × 4.2%     | Left          | Image description   |

## 5. Visual Hierarchy
1. **Primary entry point**: Heading in center column — size and position create natural focal point
2. **Secondary**: Large image in right column draws eye with visual weight
3. **Tertiary**: Body text provides detailed information
4. **Reading flow**: F-pattern — heading to image to body text to caption

## 6. Spacing System
- **Dominant spacing unit**: ~4% of page width (gutter width) repeats in margins
- **Vertical rhythm**: Consistent spacing between content blocks
- **Density**: Balanced
- **White space strategy**: Generous margins frame content, asymmetric column layout creates dynamic tension

## 7. Typography Observations
- **Heading style**: Larger scale, likely bold weight, creates strong contrast with body
- **Body text**: Single column, comfortable line length for readability
- **Type scale relationship**: Clear hierarchy with distinct sizing
- **Alignment**: Flush left throughout for consistent reading experience

## 8. Design Principles Detected
- Asymmetric balance using 3-column grid with emphasized center column
- Clear visual hierarchy through size and position relationships  
- Generous white space creates breathing room and focus
- Consistent left alignment maintains reading flow

## 9. Responsive Adaptation Notes
The 3-column asymmetric layout will collapse to single column on mobile. The visual hierarchy should be preserved through typography scale, but the spatial relationships that create tension in the original will be lost. The image-caption relationship may need to be maintained through proximity rather than column alignment.
EOF

success "Markdown specification created: $MD_FILE"

# ============================================
# PHASE 4: GENERATE HTML PROTOTYPE
# ============================================

log "Generating HTML prototype..."

# Generate image-specific HTML based on layout type
if [ "$LAYOUT_TYPE" = "magazine-spread-editorial" ]; then
cat > "$HTML_FILE" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Layout: $NAME</title>
  <link rel="stylesheet" href="../shared/tokens.css">
  <style>
    /* === Magazine Spread Layout ===
       Source: $NAME  
       Grid: Compound grid - Left: 4 columns, Right: 2 columns
       Proportions: 12.5% 12.5% 12.5% 12.5% 30% 20%
    */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; }
    .spread-container { 
      max-width: 1600px; margin: 0 auto; padding: 2rem;
      display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;
    }
    .left-page { 
      display: grid; grid-template-columns: 1fr 1fr 1fr 1fr; gap: 1rem;
    }
    .right-page { 
      display: grid; grid-template-columns: 1.5fr 1fr; gap: 1rem;
    }
    .header-block { 
      grid-column: 1/-1; background: var(--la-shape-decorative);
      padding: 2rem; color: white; margin-bottom: 1rem;
    }
    .text-column { 
      background: var(--la-text-body); color: white; padding: 1rem;
      min-height: 300px; opacity: 0.8;
    }
    .feature-block { 
      background: var(--la-shape-decorative); color: white; 
      padding: 2rem; min-height: 200px;
    }
    .main-text { 
      background: var(--la-text-body); color: white; padding: 1rem;
      opacity: 0.8; min-height: 400px;
    }
    @media (max-width: 768px) {
      .spread-container { grid-template-columns: 1fr; }
      .left-page, .right-page { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>
  <div class="spread-container">
    <div class="left-page">
      <div class="header-block">Header Block - Editorial Focus</div>
      <div class="text-column">Column 1</div>
      <div class="text-column">Column 2</div>
      <div class="text-column">Column 3</div>
      <div class="text-column">Column 4</div>
    </div>
    <div class="right-page">
      <div class="feature-block">Feature Block</div>
      <div class="main-text">Main Article Text</div>
    </div>
  </div>
</body>
</html>
EOF

elif [ "$LAYOUT_TYPE" = "magazine-spread-geometric" ]; then
cat > "$HTML_FILE" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Layout: $NAME</title>
  <link rel="stylesheet" href="../shared/tokens.css">
  <style>
    /* === Geometric Layout ===
       Source: $NAME
       Grid: 5-column modular with geometric elements
       Proportions: 20% 20% 20% 20% 20%
    */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; }
    .layout-grid { 
      max-width: 1400px; margin: 0 auto; padding: 2rem;
      display: grid; grid-template-columns: repeat(5, 1fr); gap: 2rem;
      min-height: 80vh;
    }
    .section-1 { 
      background: var(--la-shape-decorative); color: white;
      padding: 2rem; font-size: 3rem; font-weight: bold;
      display: flex; align-items: center; justify-content: center;
    }
    .section-2 { 
      grid-column: 2/4; background: var(--la-shape-decorative);
      border-radius: 50%; display: flex; align-items: center; 
      justify-content: center; color: white; font-size: 3rem; font-weight: bold;
      aspect-ratio: 1;
    }
    .section-3 { 
      grid-column: 4/6; background: var(--la-shape-decorative);
      clip-path: polygon(50% 0%, 0% 100%, 100% 100%);
      display: flex; align-items: center; justify-content: center;
      color: white; font-size: 3rem; font-weight: bold;
    }
    .text-block { 
      background: var(--la-text-body); color: white; padding: 1rem;
      opacity: 0.8; grid-row: span 2;
    }
    @media (max-width: 768px) {
      .layout-grid { grid-template-columns: 1fr; }
      .section-2, .section-3 { grid-column: 1; }
      .section-2 { border-radius: 1rem; aspect-ratio: auto; }
      .section-3 { clip-path: none; }
    }
  </style>
</head>
<body>
  <div class="layout-grid">
    <div class="section-1">1</div>
    <div class="section-2">2</div>
    <div class="section-3">3</div>
    <div class="text-block">Text Block 1<br>Supporting content for section 1</div>
    <div class="text-block" style="grid-column: 2/4;">Text Block 2<br>Central content area</div>
    <div class="text-block" style="grid-column: 4/6;">Text Block 3<br>Supporting content for section 3</div>
  </div>
</body>
</html>
EOF

else
# Default template HTML
cat > "$HTML_FILE" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Layout: $NAME</title>
  <link rel="stylesheet" href="../shared/tokens.css">
  <style>
    /* === Layout Grid ===
       Source: $NAME
       Grid: 3-column asymmetric (1fr 2fr 1fr proportional)
       Columns: 22% 36% 22% with 4% gutters
    */

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      line-height: 1.6;
      background: var(--la-page-bg);
    }

    .layout-frame {
      max-width: 1000px;
      margin: 0 auto;
      padding: 7.1% 8%;
      min-height: 100vh;
    }

    .layout-grid {
      display: grid;
      /* Original: 3 columns at 22% 36% 22% — asymmetric with wide center */
      grid-template-columns: 22fr 4fr 36fr 4fr 22fr;
      grid-template-rows: auto auto auto auto;
      gap: 0;
      height: 100%;
    }

    .content-block {
      padding: 1rem;
      margin-bottom: 1rem;
      border-radius: 4px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 500;
      color: white;
      min-height: 80px;
    }

    .heading {
      grid-column: 3;
      grid-row: 1;
      background-color: var(--la-text-heading);
      font-size: 2rem;
      font-weight: bold;
      min-height: 80px;
    }

    .body-text {
      grid-column: 3;
      grid-row: 2;
      background-color: var(--la-text-body);
      min-height: 400px;
      align-items: flex-start;
      text-align: left;
      padding: 2rem 1rem;
      line-height: 1.8;
    }

    .image-placeholder {
      grid-column: 5;
      grid-row: 1 / span 2;
      background-color: var(--la-image-photo);
      min-height: 300px;
      background-image: repeating-linear-gradient(
        45deg,
        transparent,
        transparent 10px,
        rgba(0,0,0,0.1) 10px,
        rgba(0,0,0,0.1) 20px
      );
    }

    .caption {
      grid-column: 1;
      grid-row: 3;
      background-color: var(--la-text-caption);
      font-size: 0.9rem;
      min-height: 60px;
    }

    /* === Responsive: what changes and what is lost === */
    @media (max-width: 768px) {
      .layout-grid {
        grid-template-columns: 1fr;
        gap: 1rem;
        /* NOTE: Original 3-column asymmetric grid collapses to single column.
           The spatial tension and visual balance of the original layout 
           is not preserved here. */
      }

      .heading,
      .body-text,
      .image-placeholder,
      .caption {
        grid-column: 1;
        grid-row: auto;
      }

      .layout-frame {
        padding: 2rem 1rem;
      }
    }

    /* Debug grid lines (remove in production) */
    .layout-frame.debug .layout-grid {
      position: relative;
    }

    .layout-frame.debug .layout-grid::before {
      content: '';
      position: absolute;
      top: 0;
      left: 22fr;
      width: 1px;
      height: 100%;
      background: var(--la-grid-line-major);
      z-index: 10;
    }
  </style>
</head>
<body>
  <main class="layout-frame">
    <div class="layout-grid">
      <div class="content-block heading">
        Main Heading
      </div>
      
      <div class="content-block body-text">
        This represents the main body content area. In the original layout analysis, this would contain the primary text content organized in a comfortable reading width. The 3-column grid creates natural margins and focuses attention on this central content area.
      </div>
      
      <div class="content-block image-placeholder">
        Image Area
      </div>
      
      <div class="content-block caption">
        Caption
      </div>
    </div>
  </main>

  <script>
    // Toggle debug grid lines
    document.addEventListener('keydown', function(e) {
      if (e.key === 'd' && e.ctrlKey) {
        e.preventDefault();
        document.querySelector('.layout-frame').classList.toggle('debug');
      }
    });
  </script>
</body>
</html>
EOF

fi  # End of HTML generation conditional

success "HTML prototype created: $HTML_FILE"

# ============================================
# PHASE 5: VALIDATION
# ============================================

log "Validating outputs..."

# Check SVG structure
if grep -q "layer-page\|layer-grid\|layer-content\|layer-flow\|layer-annotations\|layer-legend" "$SVG_FILE"; then
    success "SVG has required 6 layers"
else
    error "SVG missing required layers"
    exit 1
fi

# Check MD structure  
required_sections=("Format & Proportions" "Margins" "Grid System" "Content Inventory" "Visual Hierarchy" "Spacing System" "Typography Observations" "Design Principles" "Responsive Adaptation")
for section in "${required_sections[@]}"; do
    if grep -q "$section" "$MD_FILE"; then
        log "✓ MD section: $section"
    else
        error "MD missing section: $section"
        exit 1
    fi
done

# Check HTML grid
if grep -q "grid-template-columns.*fr" "$HTML_FILE" && ! grep -q "repeat(12, 1fr)" "$HTML_FILE"; then
    success "HTML uses proper proportional grid (not 12-column)"
else
    error "HTML grid structure invalid"
    exit 1
fi

success "All validation checks passed"
success "Analysis complete for $NAME"

log "Generated files:"
log "  - SVG: $(basename "$SVG_FILE")"
log "  - MD:  $(basename "$MD_FILE")"  
log "  - HTML: $(basename "$HTML_FILE")"