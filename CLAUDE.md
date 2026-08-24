# Layout Analyzer - Standard Workflow

## Image Analysis Process

When user provides an image and says "analyze":

### Step 1: Visual Analysis (Following CLAUDE_CODE_PROMPT_v2.md)
- **CRITICAL FIRST**: Determine the medium/format before detailed analysis
  - Is this a double-page spread? (Look for central spine, bilateral symmetry, complementary pages)
  - Is this a single page? (Continuous background, no gutter, unified composition)
  - Is this mobile app interface, poster, book page, magazine spread, etc.?
  - **Don't default to spread-thinking** - many layouts are single pages with asymmetric zones
- **CRITICAL**: Analyze the image directly using vision capabilities - never use filename patterns or templates
- Measure actual proportions as % of page width/height - don't assume equal columns
- Identify precise grid structure (5-column, 7-column, compound grids, asymmetric columns)
- Extract actual colors from the design (not generic pink/blue)
- Map real content elements (not "Text 1/2/3" but actual headings, captions, etc.)
- Check for golden ratio relationships (φ = 1.618)
- Detect column alignment edges and spacing patterns before interpreting

### Step 2: Generate Outputs
Generate 3 files using proper design tokens from `shared/tokens.css`:

1. **SVG Wireframe** (`*_wireframe.svg`) - MUST have 6 layers:
   - Layer 1: Page Frame & Margins (magenta stroke)
   - Layer 2: Grid System - column lines (cyan), labels at top
   - Layer 3: Content Blocks as OUTLINES (red stroke, minimal fill)
   - Layer 4: Proportional Analysis (golden ratio in gold)
   - Layer 5: Flow & Hierarchy (reading direction)
   - Layer 6: Info Panel (dark panel with ALL measurements)
   - Minimum 50+ SVG elements for detailed analysis
   - Proper XML escaping (& = &amp;, etc.)

2. **Markdown Specification** (`*_specification.md`)
   - EXACT 9-section template from v2 prompt
   - Actual measured proportions (px AND %)
   - Content inventory table with real element names
   - Golden ratio analysis and proportional relationships

3. **HTML Prototype** (`*_layout.html`)
   - CSS Grid with ACTUAL measured proportions (never repeat(n, 1fr))
   - Example: grid-template-columns: 23.6% 1.4% 23.6% 1.4% 23.6%
   - Links to `../shared/tokens.css`
   - **STANDARD**: Small floating analysis box in bottom-left using `.layer-demo` class:
     ```css
     .layer-demo {
         position: fixed;
         bottom: 20px;
         left: 20px;
         background: rgba(0,0,0,0.8);
         color: white;
         padding: 12px;
         font-family: monospace;
         font-size: 10px;
         border-radius: 4px;
         max-width: 300px;
     }
     ```
   - Honest responsive comments about what's lost

### Step 3: Quality Check
- Check SVG for syntax errors (especially & characters, missing semicolons)
- Validate all files are properly generated
- Ensure design tokens are used correctly

### Step 4: File Naming
- Ask user for the correct input filename hash
- Rename all 3 output files to match: `[input_filename_without_extension]_[type].[extension]`
- Example: `original_38e1d1a48087dcdf87632f5769bd430b_wireframe.svg`

## Standard Response Format
1. Complete visual analysis with mathematical measurements
2. Generate all 3 outputs
3. Check for errors and fix
4. Ask for filename to rename files correctly

This ensures consistent analysis quality and proper input/output file connections.

## Batch Processing Workflow (Multiple Images)

When user provides multiple images with "analyze all":

### **CRITICAL: User Must Provide Image-Hash Pairs**

**Format Required:**
```
image1.jpg : actual_hash_from_filename
image2.png : actual_hash_from_filename  
image3.gif : actual_hash_from_filename
```

**For Each Image in Sequence:**
1. **Use the exact hash provided by user** - DO NOT generate arbitrary hashes
2. **Create all 3 files with proper names from the start:**
   - `original_[user_provided_hash]_wireframe.svg`
   - `original_[user_provided_hash]_specification.md` 
   - `original_[user_provided_hash]_layout.html`
3. **Complete that image fully** (all 3 outputs) before moving to next image
4. **No renaming needed** - files use correct input hashes from creation

### **Correct Example:**
```
User provides: "layout1.jpg : 38e1d1a48087dcdf87632f5769bd430b"
Files created: 
- original_38e1d1a48087dcdf87632f5769bd430b_wireframe.svg
- original_38e1d1a48087dcdf87632f5769bd430b_specification.md
- original_38e1d1a48087dcdf87632f5769bd430b_layout.html
```

### **Benefits:**
- ✅ **Perfect input/output connection** - hashes match actual input files
- ✅ **No overwrites possible** - each image has unique user-provided names
- ✅ **No token waste** - every file creation is final with correct names
- ✅ **User can connect outputs** - hashes correspond to actual input files

**CRITICAL: Never invent hashes. Always wait for user to provide image : hash format.**