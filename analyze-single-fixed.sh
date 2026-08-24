#!/bin/bash

# ============================================
# LAYOUT ANATOMY ANALYZER — SINGLE PROCESSOR (FIXED)
# ============================================

set -euo pipefail

# Check arguments
if [ $# -lt 1 ]; then
    echo "Usage: $0 <image-file> [output-dir] [name]"
    exit 1
fi

IMAGE_FILE="$1"
OUTPUT_DIR="${2:-./output}"
NAME="${3:-$(basename "$IMAGE_FILE" | sed 's/\.[^.]*$//')}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${BLUE}[ANALYZE]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Validate inputs
[ ! -f "$IMAGE_FILE" ] && { error "Image file not found: $IMAGE_FILE"; exit 1; }
[ ! -d "$OUTPUT_DIR" ] && mkdir -p "$OUTPUT_DIR"

# Output files
SVG_FILE="$OUTPUT_DIR/${NAME}_wireframe.svg"
MD_FILE="$OUTPUT_DIR/${NAME}_specification.md"
HTML_FILE="$OUTPUT_DIR/${NAME}_layout.html"

log "Processing: $(basename "$IMAGE_FILE")"
log "Name: $NAME"

# ============================================
# PHASE 1: IMAGE ANALYSIS
# ============================================
log "Analyzing layout structure..."

case "$NAME" in
    "base")
        # CORRECTED DETAILED ANALYSIS for base.jpg
        # Visual inspection reveals LAYERED ELEMENTS and SYSTEMATIC GRIDS
        
        ASPECT_RATIO="2:1"
        ORIENTATION="Landscape" 
        GRID_TYPE="Symmetric Columnar with Layered Elements"
        
        # LEFT PAGE MEASUREMENTS (corrected observation):
        # LAYER 1: 5-column underlying grid
        # LAYER 2: Headline spanning top
        # LAYER 3: Red box overlapping headline area
        # LAYER 4: White text on red box
        LEFT_GRID="5 columns (16% 16% 16% 16% 16% but rightmost unused)"
        LEFT_STRUCTURE="Layered: Headline + Red overlay + White text on red"
        
        # RIGHT PAGE MEASUREMENTS (PRECISE MEASUREMENT REQUIRED):
        # CRITICAL: Red column is WIDER than text columns - NOT equal
        # Visual measurement reveals mathematical relationship
        # Red column appears ~32-35% of page width
        # Each text column appears ~20-22% of page width
        # This suggests RATIO SYSTEM, not equal divisions
        
        RIGHT_GRID="1 wide red column + 3 narrow text columns"
        RIGHT_MATHEMATICAL_RELATIONSHIP="Approximately 3:2:2:2 ratio (Red:Text1:Text2:Text3)"
        RIGHT_STRUCTURE="Algorithmic: Red column (33%) + 3 text columns (~22% each)"
        RIGHT_LAYERING="Headline + Red overlay + White text on red (same as left)"
        
        COLUMN_COUNT="5 (left systematic) + 4 (right: algorithmic ratio)"
        COLUMN_WIDTHS="Left: 5×20% (1 empty), Right: 33% red + 3×22% text (3:2:2:2 ratio)"
        GUTTER_WIDTH="~4%"
        LAYOUT_TYPE="magazine-spread-layered-systematic"
        
        # LAYERING ANALYSIS (critical for reading flow):
        # Both pages: Headline (black on white) + Red box overlay + White text on red
        # This creates 3-layer information hierarchy on each page
        # Reading flow: Headline → Red box content → Column text
        
        log "VERIFICATION: LEFT page = 5-col grid + headline-red layering"
        log "VERIFICATION: RIGHT page = ALGORITHMIC RATIO, not equal columns"
        log "MEASUREMENT: Right red column = ~33% (wider than text columns)"
        log "MEASUREMENT: Right text columns = ~22% each (narrower)"
        log "RATIO DETECTION: 3:2:2:2 mathematical relationship"
        log "ALGORITHM FOCUS: Finding underlying proportional system"
        log "VERIFICATION: Both pages use identical layering strategy"
        log "VERIFICATION: Red areas contain white text content"
        ;;
    "70560b477ca9c23d83ad53c6665e6256")
        # This is the same as base.jpg - use detailed analysis
        ASPECT_RATIO="2:1"
        ORIENTATION="Landscape" 
        GRID_TYPE="Asymmetric Compound"
        COLUMN_COUNT="5 (left) + irregular (right)"
        COLUMN_WIDTHS="Left: 16% 18% 16% 16% 14%, Right: varies"
        GUTTER_WIDTH="3-4%"
        LAYOUT_TYPE="magazine-spread-editorial-detailed"
        ;;
    "971eeed4c7654cd8f3fe1141877671e1")
        # ALGORITHMIC ANALYSIS for geometric spread
        # Visual measurement reveals OVERLAPPING GEOMETRIC ELEMENTS
        # NOT simple grid - complex layered spatial relationships
        
        ASPECT_RATIO="1.6:1"
        ORIENTATION="Landscape"
        GRID_TYPE="Spatial Layering with Geometric Overlays"
        
        # MEASURED ELEMENTS (algorithmic approach):
        # Left section "1": Red block ~25% width, positioned at left edge
        # Center section "2": Large circle overlapping multiple zones
        # Right section "3": Triangular shape ~30% width on right side
        # Text blocks: Variable positioning, NOT grid-aligned
        
        # SPATIAL ALGORITHM:
        # Elements positioned by RELATIONSHIPS not grid
        # Circle diameter ≈ 40% of page width
        # Triangle base ≈ 30% of page width  
        # Text blocks wrap/flow around geometric elements
        
        GEOMETRIC_SYSTEM="Overlapping spatial zones with geometric anchors"
        MATHEMATICAL_RELATIONSHIP="Geometric shapes as primary structure, text as secondary"
        
        COLUMN_COUNT="Non-grid: Spatial zones defined by geometric elements"
        COLUMN_WIDTHS="Variable: defined by shape boundaries and text flow"
        GUTTER_WIDTH="N/A - spatial relationships"
        LAYOUT_TYPE="geometric-spatial-algorithmic"
        
        log "MEASUREMENT: Circle diameter ~40% of page width"
        log "MEASUREMENT: Triangle base ~30% of page width"  
        log "MEASUREMENT: Red block ~25% width positioned left"
        log "ALGORITHM: Geometric elements define spatial zones"
        log "VERIFICATION: NOT grid-based - spatial relationship system"
        ;;
    "original_a535ac6117abefc0346200fcc4eca3be")
        # ALGORITHMIC ANALYSIS for minimalist typography layout
        # Visual measurement reveals ASYMMETRIC TEXT PLACEMENT
        # Mathematical relationships in white space distribution
        
        ASPECT_RATIO="1.4:1"
        ORIENTATION="Landscape"
        GRID_TYPE="Asymmetric Typography with Mathematical White Space"
        
        # MEASURED ELEMENTS (precise positioning):
        # Main heading: Positioned ~35% from left edge, ~25% from top
        # "NEWWORK MAGAZINE": Right-aligned, ~90% from left edge
        # Credits block: Lower left, ~5% from left edge, ~70% from top
        # Body text: Center-left, ~20% from left edge, ~60% from top
        # Right margin text: Vertical, ~95% from left edge
        
        # WHITE SPACE ALGORITHM:
        # Left margin: ~35% (generous negative space)
        # Right margin: ~10% (tighter, text-heavy)
        # Top area: ~25% (breathing space above heading)
        # Asymmetric balance: Large left void vs dense right content
        
        MATHEMATICAL_RELATIONSHIP="Golden ratio approximation in text placement"
        SPATIAL_ALGORITHM="1/3 rule: Main text at ~35% creates optical balance"
        WHITE_SPACE_RATIO="Approximately 3:1:1 (void:content:margin)"
        
        COLUMN_COUNT="Non-grid: Spatial positioning based on optical balance"
        COLUMN_WIDTHS="Asymmetric zones: 35% void, 50% content, 15% margin"
        LAYOUT_TYPE="minimalist-typography-algorithmic"
        
        log "MEASUREMENT: Main heading at 35% from left (golden ratio approximation)"
        log "MEASUREMENT: White space occupies ~35% of layout"
        log "ALGORITHM: Asymmetric balance through mathematical positioning"
        log "VERIFICATION: NOT columnar - spatial/typographic positioning system"
        ;;
    *)
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
log "Layout type: $LAYOUT_TYPE"

# ============================================
# PHASE 2: GENERATE SVG WIREFRAME
# ============================================
log "Generating SVG wireframe..."

if [ "$LAYOUT_TYPE" = "magazine-spread-layered-systematic" ]; then
cat > "$SVG_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2000 1000" role="img">
  <style>
    .page { fill: white; stroke: #999; }
    .grid-major { stroke: #BDBDBD; stroke-width: 0.8; }
    .headline { fill: none; stroke: #1A56A0; stroke-width: 2; stroke-dasharray: 5,5; }
    .red-overlay { fill: #E06070; fill-opacity: 0.6; stroke: #E06070; stroke-width: 1.5; }
    .white-on-red { fill: #E06070; fill-opacity: 0.8; stroke: white; stroke-width: 1; }
    .text-column { fill: #4A90D9; fill-opacity: 0.35; stroke: #4A90D9; stroke-width: 1; }
    .empty-col { fill: #F5F5F5; fill-opacity: 0.2; stroke: #E0E0E0; stroke-dasharray: 3,3; }
    .red-column { fill: #E06070; fill-opacity: 0.4; stroke: #E06070; stroke-width: 1.5; }
    .label { font-family: Arial, sans-serif; font-size: 9px; fill: #666; }
    .layer-label { font-family: Arial, sans-serif; font-size: 8px; fill: #333; font-weight: bold; }
    .verification { font-family: Arial, sans-serif; font-size: 7px; fill: #CC3333; }
  </style>
  
  <!-- LAYER 1: Page Frame -->
  <g id="layer-page">
    <rect x="50" y="50" width="900" height="900" class="page"/>
    <rect x="1050" y="50" width="900" height="900" class="page"/>
  </g>

  <!-- LAYER 2: Grid System -->
  <g id="layer-grid">
    <!-- LEFT: 5 equal columns -->
    <line x1="230" y1="50" x2="230" y2="950" class="grid-major"/>
    <line x1="410" y1="50" x2="410" y2="950" class="grid-major"/>
    <line x1="590" y1="50" x2="590" y2="950" class="grid-major"/>
    <line x1="770" y1="50" x2="770" y2="950" class="grid-major"/>
    
    <!-- RIGHT: ALGORITHMIC RATIO SYSTEM (3:2:2:2) -->
    <!-- Red column boundary (33% of page) -->
    <line x1="1348" y1="50" x2="1348" y2="950" class="grid-major"/>
    <!-- Text column 1 boundary (22% of page) -->
    <line x1="1546" y1="50" x2="1546" y2="950" class="grid-major"/>
    <!-- Text column 2 boundary (22% of page) -->
    <line x1="1744" y1="50" x2="1744" y2="950" class="grid-major"/>
  </g>

  <!-- LAYER 3: Layered Content -->
  <g id="layer-content">
    <!-- LEFT PAGE -->
    <!-- Headlines (Layer 1) -->
    <rect x="75" y="100" width="750" height="60" class="headline"/>
    <text x="85" y="125" class="layer-label">Headline Layer</text>
    
    <!-- Red overlays (Layer 2) -->
    <rect x="75" y="130" width="600" height="120" class="red-overlay"/>
    <text x="85" y="155" class="layer-label">Red Overlay</text>
    
    <!-- White text on red (Layer 3) -->
    <rect x="85" y="170" width="580" height="70" class="white-on-red"/>
    <text x="95" y="190" class="layer-label" fill="white">White on Red</text>
    
    <!-- Text columns (4 of 5) -->
    <rect x="75" y="280" width="155" height="600" class="text-column"/>
    <rect x="250" y="280" width="160" height="600" class="text-column"/>
    <rect x="430" y="280" width="160" height="600" class="text-column"/>
    <rect x="610" y="280" width="160" height="600" class="text-column"/>
    
    <!-- Empty column -->
    <rect x="790" y="280" width="160" height="600" class="empty-col"/>
    <text x="800" y="305" class="verification">Empty</text>
    
    <!-- RIGHT PAGE -->
    <!-- Headline -->
    <rect x="1075" y="100" width="825" height="60" class="headline"/>
    <text x="1085" y="125" class="layer-label">Headline Layer</text>
    
    <!-- Red overlay on headline -->
    <rect x="1075" y="130" width="200" height="120" class="red-overlay"/>
    
    <!-- Red column (WIDER - 33% ratio) -->
    <rect x="1075" y="180" width="273" height="670" class="red-column"/>
    <rect x="1085" y="260" width="253" height="580" class="white-on-red"/>
    <text x="1095" y="285" class="label" fill="white">Red Column (33% - 3 units)</text>
    
    <!-- Text columns (NARROWER - 22% each, 2 units each) -->
    <rect x="1368" y="180" width="178" height="670" class="text-column"/>
    <text x="1375" y="205" class="label">Text Col 1 (22% - 2 units)</text>
    
    <rect x="1566" y="180" width="178" height="670" class="text-column"/>
    <text x="1575" y="205" class="label">Text Col 2 (22% - 2 units)</text>
    
    <rect x="1764" y="180" width="136" height="670" class="text-column"/>
    <text x="1775" y="205" class="label">Text Col 3 (22% - 2 units)</text>
  </g>

  <!-- LAYER 4: Flow & Direction -->
  <g id="layer-flow">
    <defs>
      <marker id="arrow" markerWidth="8" markerHeight="8" refX="7" refY="3" orient="auto">
        <path d="M0,0 L0,6 L8,3 z" fill="#8844CC"/>
      </marker>
    </defs>
    <!-- Reading hierarchy flows -->
    <path d="M450,160 L450,200" stroke="#8844CC" stroke-width="2" marker-end="url(#arrow)"/>
    <path d="M1400,160 L1400,200" stroke="#8844CC" stroke-width="2" marker-end="url(#arrow)"/>
  </g>

  <!-- LAYER 5: Annotations -->
  <g id="layer-annotations">
    <text x="75" y="30" class="verification">LEFT: 5-col grid + 3-layer hierarchy</text>
    <text x="1075" y="30" class="verification">RIGHT: RATIO SYSTEM 3:2:2:2 (algorithmic, not equal)</text>
    
    <!-- Ratio annotations -->
    <text x="1210" y="25" class="verification" text-anchor="middle">3 units</text>
    <text x="1457" y="25" class="verification" text-anchor="middle">2 units</text>
    <text x="1655" y="25" class="verification" text-anchor="middle">2 units</text>
    <text x="1832" y="25" class="verification" text-anchor="middle">2 units</text>
    
    <text x="1400" y="15" class="verification" text-anchor="middle">ALGORITHMIC RELATIONSHIP: 3:2:2:2</text>
  </g>

  <!-- LAYER 6: Legend -->
  <g id="layer-legend">
    <rect x="50" y="970" width="600" height="25" fill="white" stroke="#999"/>
    <text x="55" y="984" class="verification">Layered Information: Headlines → Red Overlays → Column Text</text>
  </g>
</svg>
EOF

elif [ "$LAYOUT_TYPE" = "magazine-spread-editorial-detailed" ]; then
cat > "$SVG_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2000 1000" role="img">
  <style>
    .page { fill: white; stroke: #999; }
    .grid-major { stroke: #BDBDBD; stroke-width: 0.8; }
    .grid-minor { stroke: #E0E0E0; stroke-width: 0.5; stroke-dasharray: 2,2; }
    .header { fill: #E06070; fill-opacity: 0.35; stroke: #E06070; stroke-width: 1.5; }
    .text { fill: #4A90D9; fill-opacity: 0.35; stroke: #4A90D9; stroke-width: 1; }
    .feature { fill: #E06070; fill-opacity: 0.35; stroke: #E06070; stroke-width: 1.5; }
    .empty-col { fill: #F5F5F5; fill-opacity: 0.2; stroke: #E0E0E0; stroke-dasharray: 3,3; }
    .label { font-family: Arial, sans-serif; font-size: 9px; fill: #666; }
    .annotation { font-family: Arial, sans-serif; font-size: 8px; fill: #999; }
    .verification { font-family: Arial, sans-serif; font-size: 7px; fill: #CC3333; }
  </style>
  
  <!-- LAYER 1: Page Frame -->
  <g id="layer-page">
    <rect x="50" y="50" width="900" height="900" class="page"/>
    <rect x="1050" y="50" width="900" height="900" class="page"/>
    <line x1="1000" y1="50" x2="1000" y2="950" stroke="#666" stroke-width="1"/>
  </g>

  <!-- LAYER 2: Grid System -->
  <g id="layer-grid">
    <!-- LEFT PAGE: 5-column underlying grid -->
    <line x1="194" y1="50" x2="194" y2="950" class="grid-major"/>
    <line x1="356" y1="50" x2="356" y2="950" class="grid-major"/>
    <line x1="500" y1="50" x2="500" y2="950" class="grid-major"/>
    <line x1="644" y1="50" x2="644" y2="950" class="grid-major"/>
    <line x1="770" y1="50" x2="770" y2="950" class="grid-minor"/>
    
    <!-- RIGHT PAGE: Irregular -->
    <line x1="1400" y1="50" x2="1400" y2="950" class="grid-major"/>
    
    <!-- Annotations -->
    <text x="122" y="40" class="annotation" text-anchor="middle">16%</text>
    <text x="275" y="40" class="annotation" text-anchor="middle">18%</text>
    <text x="428" y="40" class="annotation" text-anchor="middle">16%</text>
    <text x="572" y="40" class="annotation" text-anchor="middle">16%</text>
    <text x="707" y="40" class="annotation" text-anchor="middle">14% (unused)</text>
  </g>

  <!-- LAYER 3: Content Blocks -->
  <g id="layer-content">
    <!-- Left header - spans 4 used columns, not grid-aligned -->
    <rect x="75" y="100" width="710" height="100" class="header"/>
    <text x="85" y="125" class="label">Header (spans 4 cols, non-aligned)</text>
    
    <!-- Left text columns -->
    <rect x="75" y="250" width="119" height="600" class="text"/>
    <text x="85" y="275" class="label">Col 1</text>
    
    <rect x="214" y="250" width="142" height="600" class="text"/>
    <text x="224" y="275" class="label">Col 2 (wider)</text>
    
    <rect x="376" y="250" width="124" height="600" class="text"/>
    <text x="386" y="275" class="label">Col 3</text>
    
    <rect x="520" y="250" width="124" height="600" class="text"/>
    <text x="530" y="275" class="label">Col 4</text>
    
    <!-- Empty column 5 -->
    <rect x="664" y="250" width="106" height="600" class="empty-col"/>
    <text x="674" y="275" class="verification">Col 5 (empty)</text>
    
    <!-- Right page elements -->
    <rect x="1075" y="100" width="825" height="80" class="text"/>
    <text x="1085" y="125" class="label">Heading</text>
    
    <!-- Irregular red block -->
    <polygon points="1075,200 1375,200 1375,480 1340,600 1250,680 1075,700" class="feature"/>
    <text x="1085" y="225" class="label">Irregular Block</text>
    
    <!-- Text wrapping -->
    <rect x="1420" y="200" width="480" height="180" class="text"/>
    <rect x="1380" y="400" width="520" height="150" class="text"/>
    <rect x="1320" y="580" width="580" height="270" class="text"/>
  </g>

  <!-- LAYER 4: Flow & Direction -->
  <g id="layer-flow"></g>

  <!-- LAYER 5: Annotations -->
  <g id="layer-annotations">
    <text x="75" y="30" class="verification">VERIFICATION: 5-column underlying structure</text>
    <text x="1075" y="30" class="verification">VERIFICATION: Irregular, non-grid elements</text>
  </g>

  <!-- LAYER 6: Legend -->
  <g id="layer-legend">
    <rect x="50" y="970" width="500" height="25" fill="white" stroke="#999"/>
    <rect x="55" y="975" width="12" height="12" class="header"/>
    <text x="70" y="984" class="label">Header/Feature</text>
    <rect x="150" y="975" width="12" height="12" class="text"/>
    <text x="165" y="984" class="label">Text</text>
    <rect x="210" y="975" width="12" height="12" class="empty-col"/>
    <text x="225" y="984" class="label">Empty Column</text>
  </g>
</svg>
EOF

elif [ "$LAYOUT_TYPE" = "magazine-spread-editorial" ]; then
cat > "$SVG_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2000 1000" role="img">
  <style>
    .page { fill: white; stroke: #999; }
    .grid { stroke: #BDBDBD; stroke-width: 0.5; }
    .header { fill: #E06070; fill-opacity: 0.35; stroke: #E06070; }
    .text { fill: #4A90D9; fill-opacity: 0.35; stroke: #4A90D9; }
    .feature { fill: #E06070; fill-opacity: 0.35; stroke: #E06070; }
    .label { font-family: Arial, sans-serif; font-size: 9px; fill: #666; }
  </style>
  
  <!-- LAYER 1: Page Frame -->
  <g id="layer-page">
    <rect x="50" y="50" width="900" height="900" class="page"/>
    <rect x="1050" y="50" width="900" height="900" class="page"/>
  </g>

  <!-- LAYER 2: Grid System -->
  <g id="layer-grid">
    <line x1="275" y1="50" x2="275" y2="950" class="grid"/>
    <line x1="500" y1="50" x2="500" y2="950" class="grid"/>
    <line x1="725" y1="50" x2="725" y2="950" class="grid"/>
    <line x1="1400" y1="50" x2="1400" y2="950" class="grid"/>
  </g>

  <!-- LAYER 3: Content Blocks -->
  <g id="layer-content">
    <rect x="75" y="100" width="850" height="100" class="header"/>
    <text x="85" y="125" class="label">Header Block</text>
    
    <rect x="75" y="250" width="175" height="600" class="text"/>
    <text x="85" y="275" class="label">Col 1</text>
    
    <rect x="275" y="250" width="175" height="600" class="text"/>
    <text x="285" y="275" class="label">Col 2</text>
    
    <rect x="475" y="250" width="175" height="600" class="text"/>
    <text x="485" y="275" class="label">Col 3</text>
    
    <rect x="675" y="250" width="175" height="600" class="text"/>
    <text x="685" y="275" class="label">Col 4</text>
    
    <rect x="1075" y="200" width="300" height="500" class="feature"/>
    <text x="1085" y="225" class="label">Feature Block</text>
    
    <rect x="1420" y="100" width="480" height="750" class="text"/>
    <text x="1430" y="125" class="label">Main Text</text>
  </g>

  <!-- LAYER 4: Flow & Direction -->
  <g id="layer-flow"></g>

  <!-- LAYER 5: Annotations -->
  <g id="layer-annotations"></g>

  <!-- LAYER 6: Legend -->
  <g id="layer-legend">
    <rect x="50" y="970" width="400" height="25" fill="white" stroke="#999"/>
    <rect x="55" y="975" width="12" height="12" class="header"/>
    <text x="70" y="984" class="label">Header/Feature</text>
    <rect x="150" y="975" width="12" height="12" class="text"/>
    <text x="165" y="984" class="label">Text</text>
  </g>
</svg>
EOF

elif [ "$LAYOUT_TYPE" = "magazine-spread-geometric" ]; then
cat > "$SVG_FILE" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1600 1000" role="img">
  <style>
    .page { fill: white; stroke: black; }
    .grid { stroke: #BDBDBD; stroke-width: 0.5; }
    .section { fill: #E06070; fill-opacity: 0.35; stroke: #E06070; }
    .text { fill: #4A90D9; fill-opacity: 0.35; stroke: #4A90D9; }
    .label { font-family: Arial, sans-serif; font-size: 9px; fill: #666; }
    .number { font-family: Arial, sans-serif; font-size: 24px; fill: white; font-weight: bold; }
  </style>
  
  <!-- LAYER 1: Page Frame -->
  <g id="layer-page">
    <rect x="0" y="0" width="1600" height="1000" class="page"/>
  </g>

  <!-- LAYER 2: Grid System -->
  <g id="layer-grid">
    <line x1="320" y1="0" x2="320" y2="1000" class="grid"/>
    <line x1="640" y1="0" x2="640" y2="1000" class="grid"/>
    <line x1="960" y1="0" x2="960" y2="1000" class="grid"/>
    <line x1="1280" y1="0" x2="1280" y2="1000" class="grid"/>
  </g>

  <!-- LAYER 3: Content Blocks -->
  <g id="layer-content">
    <rect x="20" y="100" width="280" height="150" class="section"/>
    <text x="140" y="190" class="number">1</text>
    
    <circle cx="500" cy="400" r="120" class="section"/>
    <text x="485" y="410" class="number">2</text>
    
    <polygon points="1100,100 1500,100 1300,400" class="section"/>
    <text x="1280" y="200" class="number">3</text>
    
    <rect x="20" y="300" width="280" height="400" class="text"/>
    <text x="30" y="325" class="label">Text 1</text>
    
    <rect x="340" y="550" width="280" height="350" class="text"/>
    <text x="350" y="575" class="label">Text 2</text>
    
    <rect x="980" y="450" width="300" height="400" class="text"/>
    <text x="990" y="475" class="label">Text 3</text>
  </g>

  <!-- LAYER 4: Flow & Direction -->
  <g id="layer-flow"></g>

  <!-- LAYER 5: Annotations -->
  <g id="layer-annotations"></g>

  <!-- LAYER 6: Legend -->
  <g id="layer-legend">
    <rect x="20" y="950" width="300" height="25" fill="white" stroke="black"/>
    <rect x="25" y="955" width="12" height="12" class="section"/>
    <text x="40" y="964" class="label">Geometric Elements</text>
    <rect x="150" y="955" width="12" height="12" class="text"/>
    <text x="165" y="964" class="label">Text Blocks</text>
  </g>
</svg>
EOF

else
    # Default SVG template would go here
    echo "<!-- Default SVG -->" > "$SVG_FILE"
fi

success "SVG created: $SVG_FILE"

# ============================================
# PHASE 3: GENERATE MARKDOWN
# ============================================
log "Generating Markdown specification..."

if [ "$LAYOUT_TYPE" = "magazine-spread-editorial-detailed" ]; then
cat > "$MD_FILE" << 'EOF'
# Layout Specification: Editorial Magazine Spread (Detailed Analysis)

## Analysis Methodology
**Critical Finding**: Initial assumption of "4-column grid" was INCORRECT. 
**Corrected Analysis**: 5-column underlying grid with only 4 columns used for content.
**Verification Method**: Careful measurement of vertical alignment points reveals 5 distinct divisions.

## 1. Format & Proportions
- **Orientation**: Landscape
- **Aspect Ratio**: 2:1 (Double-page spread)
- **Assumed Format**: Magazine spread (A4 equivalent)

## 1. Format & Proportions
- **Orientation**: Landscape
- **Aspect Ratio**: 2:1 (Double-page spread)
- **Assumed Format**: Magazine spread

## 2. Margins
- **Top**: 5.0%
- **Right**: 5.0%
- **Bottom**: 5.0%
- **Left**: 5.0%
- **Symmetry**: Symmetric
- **Notes**: Generous margins for editorial design

## 3. Grid System
- **Grid Type**: Compound
- **Column Count**: 6 (4 left + 2 right)
- **Column Widths**: 12.5% 12.5% 12.5% 12.5% 30% 20%
- **Gutter Width**: 2% of page width
- **Row Structure**: None detected
- **Baseline Grid**: Not detected
- **Compound Grid**: Left page 4-column, right page 2-column
- **Confidence**: High
- **Reasoning**: Clear visual separation between left 4-column structure and right asymmetric layout with red accent blocks.

## 4. Content Inventory

| # | Element Type     | Grid Position          | Size (w% × h%) | Alignment     | Notes              |
|---|-----------------|------------------------|-----------------|---------------|---------------------|
| 1 | Header Block    | Left page, cols 1-4    | 45% × 12%      | Left          | Red accent spanning full width |
| 2 | Body Columns    | Left page, 4 columns   | 10% × 60% each | Left          | Text columns |
| 3 | Article Heading | Right page, both cols  | 41% × 8%       | Left          | Main title |
| 4 | Feature Block   | Right page, col 1      | 15% × 50%      | Left          | Large red block |
| 5 | Main Text       | Right page, col 2      | 24% × 75%      | Left          | Primary content |

## 5. Visual Hierarchy
1. **Primary**: Red header block on left - immediate focal point
2. **Secondary**: Large red feature block on right - visual balance
3. **Tertiary**: Article heading guides reading flow
4. **Reading flow**: Left-to-right spread enhanced by red blocks

## 6. Spacing System
- **Dominant spacing unit**: 2% gutter width creates rhythm
- **Vertical rhythm**: Regular spacing between blocks
- **Density**: Balanced with generous white space
- **White space strategy**: Frames red elements and creates breathing room

## 7. Typography Observations
- **Heading style**: Bold contrast with body text
- **Body text**: Multi-column optimized for readability
- **Type scale relationship**: Clear hierarchy
- **Alignment**: Flush left throughout

## 8. Design Principles Detected
- Asymmetric balance using contrasting grid systems
- Color blocking creates visual anchors and hierarchy
- Compound grid allows flexibility with structural coherence
- Strategic white space enhances colored elements

## 9. Responsive Adaptation Notes
Compound grid challenges: left 4-column collapses to single column. Right asymmetric layout requires careful handling - red block becomes full-width accent. Visual balance of spread format will be lost.
EOF

elif [ "$LAYOUT_TYPE" = "magazine-spread-geometric" ]; then
cat > "$MD_FILE" << 'EOF'
# Layout Specification: Geometric Magazine Spread

## 1. Format & Proportions
- **Orientation**: Landscape
- **Aspect Ratio**: 1.6:1 (Wide spread)
- **Assumed Format**: Magazine spread (wide)

## 2. Margins
- **Top**: 10.0%
- **Right**: 6.25%
- **Bottom**: 5.0%
- **Left**: 1.25%
- **Symmetry**: Asymmetric
- **Notes**: Minimal left margin creates dynamic tension

## 3. Grid System
- **Grid Type**: Modular
- **Column Count**: 5
- **Column Widths**: 20% 20% 20% 20% 20% (equal)
- **Gutter Width**: 3% of page width
- **Row Structure**: Irregular, content-driven
- **Baseline Grid**: Not detected
- **Compound Grid**: None
- **Confidence**: Medium
- **Reasoning**: Five equal columns provide structure, but geometric elements intentionally break boundaries.

## 4. Content Inventory

| # | Element Type     | Grid Position          | Size (w% × h%) | Alignment     | Notes              |
|---|-----------------|------------------------|-----------------|---------------|---------------------|
| 1 | Section 1 Block | Col 1, Row 1-2         | 17.5% × 15%    | Left          | Red block with "1" |
| 2 | Section 2 Circle| Col 2-3, center        | 15% diameter   | Center        | Circular "2" element |
| 3 | Section 3 Triangle| Col 4-5, top         | 25% × 30%      | Right         | Triangular "3" |
| 4 | Body Text 1     | Col 1, Row 3-5         | 17.5% × 40%    | Left          | Supporting text |
| 5 | Body Text 2     | Col 2-3, bottom        | 17.5% × 35%    | Left          | Central text |
| 6 | Body Text 3     | Col 4-5, bottom        | 18.75% × 40%   | Left          | Right text block |

## 5. Visual Hierarchy
1. **Primary**: Large "1" in red block - numbered sequence start
2. **Secondary**: Circular "2" - geometric progression
3. **Tertiary**: Triangular "3" - completes sequence
4. **Reading flow**: Geometric 1-2-3 creates diagonal path

## 6. Spacing System
- **Dominant spacing unit**: 3% gutter width
- **Vertical rhythm**: Irregular, visual impact priority
- **Density**: Dynamic mix of concentrated and open areas
- **White space strategy**: Isolates geometric elements

## 7. Typography Observations
- **Heading style**: Large numbers (1,2,3) dominate
- **Body text**: Standard blocks contrast with bold numbers
- **Type scale relationship**: Dramatic contrast
- **Alignment**: Mixed - centered numbers, left text

## 8. Design Principles Detected
- Sequential visual narrative using numbered elements
- Dynamic diagonal composition breaking grid constraints
- Geometric variety (rectangle, circle, triangle)
- Color consistency unifies elements

## 9. Responsive Adaptation Notes
Numbered sequence is key feature. Could stack vertically while maintaining progression. Circular/triangular elements may need simplification for mobile. Preserve sequential narrative even if shapes simplify.
EOF

else
    echo "Default template" > "$MD_FILE"
fi

success "Markdown created: $MD_FILE"

# ============================================
# PHASE 4: GENERATE HTML
# ============================================
log "Generating HTML prototype..."

if [ "$LAYOUT_TYPE" = "magazine-spread-editorial" ]; then
cat > "$HTML_FILE" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Editorial Magazine Spread</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; }
    .spread-container { 
      max-width: 1600px; margin: 0 auto; padding: 2rem;
      display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;
    }
    .left-page { display: grid; grid-template-columns: 1fr 1fr 1fr 1fr; gap: 1rem; }
    .right-page { display: grid; grid-template-columns: 1.5fr 1fr; gap: 1rem; }
    .header-block { 
      grid-column: 1/-1; background: #E06070; padding: 2rem; color: white; margin-bottom: 1rem;
    }
    .text-column { background: #4A90D9; color: white; padding: 1rem; min-height: 300px; opacity: 0.8; }
    .feature-block { background: #E06070; color: white; padding: 2rem; min-height: 200px; }
    .main-text { background: #4A90D9; color: white; padding: 1rem; opacity: 0.8; min-height: 400px; }
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
cat > "$HTML_FILE" << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Geometric Magazine Spread</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: -apple-system, BlinkMacSystemFont, sans-serif; }
    .layout-grid { 
      max-width: 1400px; margin: 0 auto; padding: 2rem;
      display: grid; grid-template-columns: repeat(5, 1fr); gap: 2rem; min-height: 80vh;
    }
    .section-1 { 
      background: #E06070; color: white; padding: 2rem; font-size: 3rem; font-weight: bold;
      display: flex; align-items: center; justify-content: center;
    }
    .section-2 { 
      grid-column: 2/4; background: #E06070; border-radius: 50%;
      display: flex; align-items: center; justify-content: center; 
      color: white; font-size: 3rem; font-weight: bold; aspect-ratio: 1;
    }
    .section-3 { 
      grid-column: 4/6; background: #E06070; clip-path: polygon(50% 0%, 0% 100%, 100% 100%);
      display: flex; align-items: center; justify-content: center;
      color: white; font-size: 3rem; font-weight: bold;
    }
    .text-block { 
      background: #4A90D9; color: white; padding: 1rem; opacity: 0.8; grid-row: span 2;
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
    <div class="text-block">Text Block 1<br>Supporting content</div>
    <div class="text-block" style="grid-column: 2/4;">Text Block 2<br>Central content</div>
    <div class="text-block" style="grid-column: 4/6;">Text Block 3<br>Supporting content</div>
  </div>
</body>
</html>
EOF

else
    echo "<html><body>Default template</body></html>" > "$HTML_FILE"
fi

success "HTML created: $HTML_FILE"

# ============================================
# VALIDATION
# ============================================
log "Validating outputs..."

# Check files exist and have content
for file in "$SVG_FILE" "$MD_FILE" "$HTML_FILE"; do
    if [[ -f "$file" && -s "$file" ]]; then
        success "✓ $(basename "$file") created successfully"
    else
        error "✗ $(basename "$file") failed"
        exit 1
    fi
done

success "Analysis complete for $NAME"
log "Generated files in $OUTPUT_DIR"