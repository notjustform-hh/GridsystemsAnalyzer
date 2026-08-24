# Layout Anatomy Analyzer

A tool that extracts the structural anatomy of graphic design layouts from images, generating three complementary outputs: SVG wireframes, Markdown specifications, and HTML prototypes.

## Overview

The Layout Anatomy Analyzer processes editorial design, posters, book spreads, brochures, annual reports, and other graphic design layouts to understand their underlying grid systems and spatial relationships. Unlike typical web-centric tools, it preserves the complexity of professional graphic design—asymmetric grids, compound systems, and unconventional column structures.

## Key Features

- **Precise Grid Analysis**: Detects actual grid structures (5-column, 7-column, compound grids) without normalizing to web standards
- **Three Output Formats**: 
  - SVG wireframes for structural analysis
  - Markdown specifications for documentation
  - HTML prototypes for responsive interpretation
- **Design Token Consistency**: Uses a standardized color system across all outputs
- **Swiss Design Focus**: Optimized for modernist, editorial, and typographic layouts

## Installation

```bash
git clone <repository>
cd layout-analyzer
chmod +x analyze.sh analyze-single.sh
```

## Usage

### Process All Images

```bash
# Process all images in input/ directory
./analyze.sh

# Process with verbose output
./analyze.sh --verbose

# Custom input/output directories
./analyze.sh --input my-images --output my-results
```

### Process Single Image

```bash
# Process one image
./analyze-single.sh input/poster.png

# Specify output location and name
./analyze-single.sh input/brochure.jpg output/brochure-analysis brochure-v1
```

### Command Line Options

```bash
./analyze.sh [OPTIONS]

Options:
  -i, --input DIR     Input directory (default: ./input)
  -o, --output DIR    Output directory (default: ./output)  
  -v, --verbose       Verbose output
  -h, --help          Show help
```

## Project Structure

```
layout-analyzer/
├── input/                          # Drop layout images here
│   └── *.png, *.jpg, *.webp
├── output/
│   └── {image-name}/
│       ├── {image-name}_wireframe.svg      # Structural diagram
│       ├── {image-name}_specification.md   # Grid documentation
│       └── {image-name}_layout.html        # Responsive prototype
├── shared/
│   ├── tokens.css                  # Design system colors & typography
│   ├── svg-template.svg            # Reference SVG structure
│   └── wireframe-styles.css        # SVG styling reference
├── analyze.sh                      # Main processor (batch)
├── analyze-single.sh               # Single image processor
└── README.md
```

## Output Formats

### 1. SVG Wireframe (`*_wireframe.svg`)

Structural diagram with exactly 6 layers:
- **Layer 1**: Page Frame (margins, boundaries)
- **Layer 2**: Grid System (columns, gutters, baselines)  
- **Layer 3**: Content Blocks (text, images, shapes)
- **Layer 4**: Flow & Direction (reading paths, hierarchy)
- **Layer 5**: Annotations (measurements, alignments)
- **Layer 6**: Legend (color coding explanation)

### 2. Markdown Specification (`*_specification.md`)

Comprehensive analysis with 9 sections:
- Format & Proportions
- Margins  
- Grid System (with confidence level and reasoning)
- Content Inventory (tabular breakdown)
- Visual Hierarchy
- Spacing System
- Typography Observations
- Design Principles Detected
- Responsive Adaptation Notes

### 3. HTML Prototype (`*_layout.html`)

Responsive web interpretation:
- CSS Grid with **actual proportions** from analysis
- Design token integration
- Single breakpoint (mobile collapse)
- Commented CSS explaining grid decisions
- Preservation notes about what's lost in responsive translation

## Design Philosophy

### Critical Principle: No Grid Oversimplification

The tool **never** normalizes layouts to standard web grids (12-column, Bootstrap, etc.). Instead:

- ✅ **Preserves actual structure**: 5-column grid stays 5-column
- ✅ **Maintains proportions**: Column widths like `2:1:1:1:2` are documented exactly
- ✅ **Detects compound grids**: Multiple overlaid systems  
- ✅ **Records asymmetry**: Unequal column widths and irregular spacing
- ❌ **Never retrofits**: Complex layouts aren't forced into simple systems

### Analysis Process

1. **Observe** → Identify all visible elements and positions
2. **Measure** → Determine proportional relationships  
3. **Detect Patterns** → Find grid lines and alignments
4. **Name the System** → Describe using appropriate terminology
5. **Never Retrofit** → If it doesn't fit standard patterns, document what's actually there

## Design Tokens

All outputs use consistent colors from `shared/tokens.css`:

```css
/* Structure */
--la-page-bg: #FFFFFF;          /* Page background */
--la-margin: #F5F5F5;           /* Margin areas */
--la-grid-line: #E0E0E0;        /* Grid lines */
--la-gutter: #EEEEEE;           /* Gutters */

/* Content Types */  
--la-text-body: #4A90D9;        /* Body text (blue family) */
--la-text-heading: #1A56A0;     /* Headings (dark blue) */
--la-image-photo: #E8A838;      /* Photographs (amber family) */
--la-shape-decorative: #E06070; /* Decorative elements (rose family) */

/* Annotations */
--la-dimension-line: #CC3333;   /* Measurements (red) */
--la-alignment-line: #33AA33;   /* Alignments (green) */
--la-direction-vector: #8844CC; /* Flow indicators (purple) */
```

**Rule**: Never create new tokens. Map content to existing categories.

## Quality Validation

Each run automatically validates:

### Must-Pass Checks ❌→⛔
- SVG has exactly 6 layers with correct IDs
- SVG uses only predefined color tokens  
- Markdown has all 9 required sections
- HTML grid uses actual proportions (not `repeat(12, 1fr)`)
- No new design tokens invented
- No hallucinated elements

### Should-Pass Checks ⚠️
- Proportions consistent across SVG/MD/HTML (±2% tolerance)
- Column counts match between outputs
- Content inventory matches visual elements

## Supported Image Formats

- PNG
- JPG/JPEG  
- WEBP

## Examples

### Input
```bash
./analyze-single.sh input/swiss-poster-1962.png
```

### Generated Output
```
output/swiss-poster-1962/
├── swiss-poster-1962_wireframe.svg      # 6-layer structural diagram
├── swiss-poster-1962_specification.md   # Grid analysis with confidence ratings  
└── swiss-poster-1962_layout.html        # Responsive CSS Grid implementation
```

The specification might detect:
```markdown
## 3. Grid System
- **Grid Type**: Modular
- **Column Count**: 5  
- **Column Widths**: 15% 20% 30% 20% 15%
- **Confidence**: High
- **Reasoning**: Five distinct vertical alignments detected. Asymmetric 
  proportions create dynamic balance with emphasized center column.
```

The HTML would implement:
```css
.layout-grid {
  /* Original: 5 columns at 15% 20% 30% 20% 15% — asymmetric emphasis on center */
  grid-template-columns: 15fr 20fr 30fr 20fr 15fr;
  gap: 4%; /* Measured gutter width */
}
```

## Development Notes

The current implementation uses template-based analysis for demonstration. A production version would integrate computer vision libraries (OpenCV, TensorFlow) for automated layout detection.

Key areas for enhancement:
- Automated grid line detection
- Content type classification  
- Baseline grid recognition
- Typography scale analysis

## Troubleshooting

### Permission Errors
```bash
chmod +x analyze.sh analyze-single.sh
```

### No Images Found
Check supported formats: PNG, JPG, JPEG, WEBP in the input directory.

### Validation Failures
- Ensure SVG templates follow the 6-layer structure
- Verify HTML doesn't use `repeat(12, 1fr)` patterns
- Check all 9 Markdown sections are present

## Contributing

When extending the analyzer:

1. **Preserve the anti-oversimplification principle**
2. **Follow the exact layer structure for SVGs** 
3. **Use only existing design tokens**
4. **Include confidence ratings in grid analysis**
5. **Document what's lost in responsive translation**

The goal is surgical precision in documenting layout systems, not convenience or standardization.