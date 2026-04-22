---
name: rn-to-figma
description: Generate a Figma component from a BTMobile React Native source component and publish a gap audit to Confluence. Use when asked to build, audit, or sync a BTMobile component to Figma.
argument-hint: "[ComponentName]"
disable-model-invocation: true
---

# React Native -> Figma

Generate a Figma component from BTMobile source and publish a gap audit to Confluence.

## Inputs
The user provides a component name (e.g. "Button", "BTBanner", "BTSegmentedControl").

At the start of every session, ask all of the following before proceeding:

1. > "What's the path to your BTMobile repo? (default: `~/Dev/BTMobile`)"
   If the user presses enter or says nothing, use `~/Dev/BTMobile`. Store as `$BTMOBILE_PATH`.

2. > "Is the Figma MCP console running from **Blueprint Base**?"
   Do not proceed until the user confirms yes.
   **Note:** Blueprint Base must be open for icon lookup and token inspection, but its variables **cannot be bound cross-file** to nodes in Mobile Design System. Variable binding will always use hex fallbacks — this is a known Figma limitation, not a script error. Document it as a gap in the audit.

3. > "Is the Figma MCP console running from **Mobile Design System (React Native)**?"
   Do not proceed until the user confirms yes.

---

## Step 1 — Read the BTMobile implementation

Search `$BTMOBILE_PATH` for the component. Check all of:
- `$BTMOBILE_PATH/packages/core/ui/components/` — main component file
- `$BTMOBILE_PATH/packages/core/ui/gluestack/ui/` — Gluestack theme file (resolved color classes → hex values live here)
- `$BTMOBILE_PATH/apps/storybook/src/Components/` — Storybook stories (often **not** co-located with the component)
- `$BTMOBILE_PATH/packages/core/ui/components/**/*.stories.tsx` — fallback story location

Read the main component file, its Gluestack theme file, and its story file. Extract:
- All props and their accepted values (variant axes)
- How colors are resolved — trace from NativeWind class → Gluestack theme file → hex value
- Layout values (padding, gap, border radius, border width, sizing)
- Typography (font size, weight, family)
- Icons used per variant (note which icon library: Gluestack, Phosphor, Lucide, etc.)
- Any states (Default, Active, Disabled, Loading, etc.)
- Which prop values the Storybook actually exercises — pin Figma to those only

### If no RN component exists (native-only)

If searching the RN paths yields nothing — no core-ui file, no Storybook stories — the component is likely native-only. In that case:

- Search iOS source: `apps/bt-native/ios/` for relevant Swift files (view controllers, factories, theme files)
- Search Android source: `apps/bt-native/android/` for relevant Kotlin/XML files (layouts, color state lists, style attrs)
- Extract the same information (colors, layout, states, icons) from the native source
- Note in the audit intro that no RN component exists and the Figma component is a design reference only
- Use `(Native)` in the Confluence page title instead of `(BTComponentClass)`:
  `Bottom Nav Gap Audit: BTMobile (Native) ↔ BDS Base`

---

## Step 2 — Read Blueprint Base in Figma

Use `figma_list_open_files` to find `Blueprint Base`. If not open, ask the user to open it.

Read:
- Variables/tokens: `figma_get_variables` — capture Global and Alias token collections
- Text styles: `figma_get_text_styles`
- Icons: search for equivalents to the component's RN icons using `figma_search_components`

Map each BTMobile value to the closest Blueprint Base token. Flag any BTMobile values that have no Blueprint Base equivalent as **mismatches**.

**Known limitation:** Blueprint Base Figma variables cannot be bound to nodes in the Mobile Design System file (cross-file variable scope is not supported via the plugin API). Record the hex fallback values now — they will be used in Step 4, and the inability to bind will be documented as a gap.

**MDS local variables:** The Mobile Design System file has its own local variable collections (`color/*`, `surface/*`, `border/*`, `fg/*`, `typography/*`). These ARE bindable via the plugin API and should be used directly when available — they are not subject to the cross-file limitation. Use `figma.variables.setBoundVariableForPaint(fill, 'color', mdsVar)` to bind them. Hex fallbacks are only required for Blueprint Base tokens.

---

## Step 3 — Confirm the Figma target page

Use `figma_list_open_files` to find `Mobile Design System (React Native)`. If not open, ask the user to open it.

Use `figma_list_slides` (or `figma_get_file_data`) to list available pages.

**Always ask the user to confirm which page the component should be placed on before building.**

---

## Step 4 — Build the Figma component

Navigate to the confirmed page in `Mobile Design System (React Native)`.

### Async API rules (non-negotiable)
All `figma_execute` scripts **must** use async Figma APIs when working across pages:
- `await figma.setCurrentPageAsync(page)` — **never** `figma.currentPage = page` (throws error)
- `await figma.getNodeByIdAsync(id)` — **never** `figma.getNodeById(id)` after a page switch (throws error)
- `await figma.variables.getVariableByIdAsync(id)` — already async, no change needed

### Build process
1. Take a screenshot of the target page first to find clear space and avoid overlapping existing content
2. **If content already exists for this component:** inspect it before building. Call `figma.variables.getVariableByIdAsync()` on existing fills and strokes to discover which MDS variables are already in use — replicate those same bindings in your build rather than sourcing fresh. Use the existing frame as a layout and size reference.
3. Check for an existing Section/Frame for this component — create one if absent
4. Build all variants as individual components, 1:1 with the RN Storybook spec. For colors: use MDS local variables where they exist (bindable directly), and hex fallbacks only for Blueprint Base tokens (cross-file binding not supported)
5. For border/divider strokes, check for `border/default` or other `border/*` MDS variables before hardcoding a color. Bind with `figma.variables.setBoundVariableForPaint(stroke, 'color', borderVar)`
6. **If the component has a clear item/container hierarchy** (e.g., tab items inside a nav bar, chips inside a chip group): build **two component sets** — the atomic item set first, then the assembled parent set. Place both inside the same Section
7. **For components that sit at the bottom edge of the screen** (tab bars, bottom toolbars): account for the iPhone home indicator safe area. Set `paddingBottom: 34` on the bar component so total height = content height + 34pt (e.g., 49pt content + 34pt = 83pt total)
8. Combine with `figma.combineAsVariants(allComponents, page)` — **then immediately run a grid layout pass** (see below), because `combineAsVariants` stacks all children at (0,0)
9. After each `figma_execute` call, take a screenshot and check:
   - All variant axes represented and readable
   - Alignment, spacing, and visual balance match the RN Storybook
   - No overlapping nodes
10. Iterate up to 3 times to fix issues, then take a final verification screenshot

### Grid layout pass (required after `combineAsVariants`)

After combining, position children in a grid and resize the component set to fit:

```javascript
const GAP = 20;
const ROWS = /* number of inner-loop values (e.g. actions) */;
const COLS = /* total variants / ROWS */;

// Find max width per column
const colWidths = new Array(COLS).fill(0);
set.children.forEach((child, i) => {
  const col = Math.floor(i / ROWS);
  colWidths[col] = Math.max(colWidths[col], child.width);
});

// Build cumulative x offsets
const colX = [];
let cx = GAP;
for (let c = 0; c < COLS; c++) { colX.push(cx); cx += colWidths[c] + GAP; }

// Position each variant
const rowH = set.children[0].height;
set.children.forEach((child, i) => {
  child.x = colX[Math.floor(i / ROWS)];
  child.y = GAP + (i % ROWS) * (rowH + GAP);
});

// Resize component set to fit content
set.resizeWithoutConstraints(cx, GAP + ROWS * (rowH + GAP));
figma.viewport.scrollAndZoomIntoView([set]);
```

---

## Step 5 — Write the Confluence audit page

### Page title format
`[Common Name] Gap Audit: BTMobile ([BTComponentClass]) ↔ BDS Base`

When the BT component class name differs from the common name, include it in parens (e.g. `BTBanner`). When they're the same, omit the parens (e.g. `Button Gap Audit: BTMobile ↔ BDS Base`).

### Parent page
- Space: `UX`
- Parent page ID: `6640009227` (`RN component audit`)
- Check for an existing page with the same title first — update it rather than creating a duplicate

### Page structure (match existing audit format exactly)

```
[Intro paragraph: what the audit covers, source files referenced]

_Source: [file paths / package names]. Audit generated via MCP on [today's date]._

## What [ComponentName] Defines

### Variant axes
[table: Prop | Values]

### Color resolution
[table: Action/element | BTMobile code token | Resolved hex | Blueprint Base variable mapped | Blueprint Base resolved hex]

### Layout spec
[table: Property | Value | Source | BDS token used]

### Typography
[table: Element | NativeWind/RN class | Weight | BDS text style mapped]

### Icons (if applicable)
[table: Action | RN icon component | Blueprint Base component]

## What Blueprint Base Defines
[Narrative summary of relevant token collections — Global, Alias, Text Styles — and what's present/absent for this component]

## Gaps
### 1. [Gap title]
[Description. Who's affected. What needs to change.]
**Owner:** [BDS | BTMobile | Documentation | BDS (Blueprint Base) | BDS (token package)]

[repeat for each gap]

## Figma Component
[Where the component set lives: page name, file name, variant count]

## Summary
[table: Gap | Affected side | Severity]
```

### Severity scale
- **Low** — visual impact minimal or standard convention gap
- **Medium** — visible inconsistency or token governance issue
- **High** — breaks theming, accessibility, or cross-platform parity

### Owner tags
- `BDS` — Buildertrend Design System team (Blueprint Base or token package)
- `BTMobile` — Mobile engineering / Figma design file
- `Documentation` — No code change needed; requires a callout in usage notes

### Confluence API (v2)
Use `mcp__confluence__conf_post` to create the page:
```json
{
  "spaceId": "374440261",
  "status": "current",
  "title": "[derived title]",
  "parentId": "6640009227",
  "body": {
    "representation": "storage",
    "value": "[HTML content]"
  }
}
```

Use `mcp__confluence__conf_get` + `mcp__confluence__conf_put` to update an existing page (requires current version number).

---

## Key references (verify before using — these may change)

- BTMobile repo: `$BTMOBILE_PATH` (prompted at session start, default `~/Dev/BTMobile`)
- Figma token source: `Blueprint Base` (open file — for inspection only, not cross-file binding)
- Figma build target: `Mobile Design System (React Native)` (open file, confirm page)
- Confluence space: `UX` / space ID: `374440261`
- Confluence parent: `RN component audit` — page ID `6640009227`
- Confluence root doc: `https://btwiki.atlassian.net/wiki/x/C4DGiwE`
