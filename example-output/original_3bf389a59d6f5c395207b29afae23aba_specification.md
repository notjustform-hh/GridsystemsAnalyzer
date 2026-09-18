# Layout Specification: Swiss Typography Double-Page Spread

## 1. Format & Proportions
- **Orientation**: Landscape spread
- **Aspect Ratio**: 1.75:1 (overall spread)
- **Page Ratio vs φ**: 1.75 (φ = 1.618) ✓ 92% proximity to golden ratio
- **Assumed Format**: Magazine spread, likely 210×297mm (A4) equivalent per page
- **Spread or Single**: Double-page spread with central spine

## 2. Margins
- **Top**: 40px (5.0%)
- **Right/Outer**: 40px (2.9% per page)
- **Bottom**: 40px (5.0%)
- **Left/Inner**: 40px (2.9% per page)
- **Gutter**: 40px (2.9%) central spine separation
- **Symmetry**: Perfectly symmetrical margins across spread - classical Swiss approach
- **Notes**: Consistent 40px margins create clean mathematical framework for content

## 3. Grid System
- **Grid Type**: Symmetrical 3-column system per page
- **Column Count per Page**: 3 columns per page, 6 total across spread
- **Total Columns (spread)**: 6 columns with central gutter
- **Column Widths**: 180px each (33.3% per page) with equal distribution
- **Column Width (px)**: Left page: 180px | 180px | 180px | Right page: 180px | 180px | 180px
- **Gutter Width**: 20px between columns, 40px at spine
- **Row/Zone Structure**: 5 horizontal zones: Header(120px) | Upper(150px) | Main(150px) | Mid(150px) | Footer(150px)
- **Baseline Grid**: Implied 20px baseline grid for typographic alignment
- **Compound Grid**: No - single systematic grid applied consistently
- **Confidence**: High
- **Reasoning**: Clear 3-column divisions visible on both pages, consistent spacing intervals, Swiss grid methodology

## 4. Content Inventory

| # | Element Type | Position (x%, y%) | Size (w% × h%) | Grid Span | Color/Weight | Notes |
|---|---|---|---|---|---|---|
| 1 | Page number "3" | 6%, 11% | 3% × 8% | Left col 1 | Black/Bold | Navigation element |
| 2 | Caption text block | 34%, 11% | 9% × 10% | Left col 3 | Black/Light | Small explanatory text |
| 3 | Display type "merz 60" | 6%, 28% | 20% × 15% | Left col 1-2 | Black/Bold | Primary heading |
| 4 | Horizontal separator | 6%, 48% | 35% × 0.1% | Left col 1-3 | Black/Thin | Visual division |
| 5 | Fragmented text block | 6%, 53% | 13% × 23% | Left col 1 | Black/Medium | "ipo rafise onaz letr" |
| 6 | Page number "4" | 56%, 60% | 3% × 8% | Right col 1 | Black/Bold | Navigation element |
| 7 | Caption text block | 84%, 11% | 9% × 10% | Right col 3 | Black/Light | Small explanatory text |
| 8 | "april 60" text | 67%, 48% | 11% × 8% | Right col 2 | Black/Medium | Temporal identifier |
| 9 | "tipo" heading | 84%, 48% | 7% × 10% | Right col 3 | Black/Bold | Category heading |
| 10 | "im prime" text | 84%, 65% | 9% × 10% | Right col 3 | Black/Medium | Secondary text element |

## 5. Visual Hierarchy
1. **Primary**: "merz 60" display typography - largest scale, left page dominance
2. **Secondary**: Page numbers "3" and "4" - navigation anchors
3. **Tertiary**: "tipo" and fragmented text block - supporting typographic elements
4. **Reading flow**: Left page number → "merz 60" → Fragmented text → Across spine → Right page elements

## 6. Spacing & Proportional System
- **Dominant spacing unit**: 20px (column gutters, baseline grid) and 40px (margins, major divisions)
- **Golden ratio presence**: Strong - spread ratio 1.75:1 approaches φ, content positioning follows golden section
- **Vertical rhythm**: 150px zone heights create 5-zone vertical grid system
- **Density**: Low density, high white space ratio (~70% white space)
- **White space strategy**: White space as primary design element, content as punctuation in space

## 7. Typography Observations
- **Heading scale**: Display type ~6x larger than body text, moderate hierarchy
- **Body text columns**: Single column approach with fragmented line breaks
- **Type scale**: Sans-serif family throughout, consistent weight variation
- **Alignment**: Primarily flush left alignment, maintaining grid relationships
- **Special typography**: Fragmented text creates rhythm and texture ("ipo rafise onaz letr")

## 8. Design Principles Detected
- **Swiss International Style**: Grid as invisible structure, typography as primary element
- **Asymmetric balance**: Heavy left page ("merz 60") balanced by distributed right page content
- **Modular construction**: Each element fits precisely within grid framework
- **Minimal color palette**: Black typography on white ground, no decorative elements
- **Typography as image**: Letters and words treated as graphic elements in space
- **Mathematical precision**: 20px/40px spacing system creates consistent proportional relationships

## 9. Responsive Adaptation Notes
The spread format will completely collapse on mobile, losing the fundamental bilateral reading experience that defines the design. The left page's dominant "merz 60" will lose its relationship to the distributed right page elements, breaking the asymmetric balance principle. The 3-column grid per page will stack vertically, eliminating the horizontal rhythm that creates breathing space around each element. Most critically, the spine relationship - central to spread-based design - will be lost, converting this from a spatial composition into a linear scroll. The Swiss grid system's mathematical precision can be preserved through careful rem-based spacing, but the essential spread experience of simultaneous left-right comparison will be fundamentally altered. Consider maintaining the grid proportions but accepting the loss of bilateral reading experience.