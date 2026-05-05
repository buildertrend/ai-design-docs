---
name: rn-to-figma
description: Generate a Figma component from a BTMobile React Native source component and publish a gap audit to Confluence. Use when asked to build, audit, or sync a BTMobile component to Figma.
argument-hint: "[ComponentName]"
disable-model-invocation: true
---

# React Native → Figma

Generate a Figma component from BTMobile source and publish a gap audit to Confluence.

## Inputs

The user provides a component name (e.g. "Button", "BTBanner", "BTSegmentedControl").

At the start of every session, if either piece of info is missing, ask for both together in a single message so the user can answer in one reply:

> To get started, I need two things — you can answer both in one reply:
>
> 1. **BTMobile repo path** — leave blank to use the default (`~/Dev/BTMobile`), or provide the full path
> 2. **Which component** would you like to build in Figma?

If the user provides both upfront (e.g. as skill arguments), skip the prompt entirely. If only the component is provided, use the default path without asking.

---

## Tool usage rules

**Screenshots:** Always call `get_screenshot` with `enableBase64Response: true` so the image is returned inline — no Bash or `curl` needed. Never use shell commands to download screenshot URLs.

---

## Step 1 — Read the BTMobile implementation

Check two source locations in order:

1. `$BTMOBILE_PATH/packages/core/ui/components/[ComponentName].tsx`
   - For subdirectory components: `$BTMOBILE_PATH/packages/core/ui/components/[ComponentName]/[ComponentName].tsx`
2. Storybook story: `$BTMOBILE_PATH/apps/storybook/src/Components/`
   - Search for the component's story file. If no story exists, skip and note it in the audit. The story informs which prop combinations are exercised — pin Figma variants to those values.

If the component tsx file is not found, **stop and ask the user where to find it** before proceeding.

### If no RN component exists (native-only)

If the component file is not found at the expected path — no core-ui file, no Storybook stories — the component is likely native-only. In that case:

- Search iOS source: `$BTMOBILE_PATH/apps/bt-native/ios/` for relevant Swift files (view controllers, factories, theme files)
- Search Android source: `$BTMOBILE_PATH/apps/bt-native/android/` for relevant Kotlin/XML files (layouts, color state lists, style attrs)
- Extract the same information (colors, layout, states, icons) from the native source
- Note in the audit intro that no RN component exists and the Figma component is a design reference only
- Append `(Native)` to the Confluence page title: e.g. `Bottom Nav Gap Audit (Native)`

Extract:

- **Implementation type** — does the component import from Gluestack (`@gluestack-ui/...`)? A 3rd-party library (e.g. `expo-modules`)? Or is it built entirely from RN primitives? Record this — it affects what styling is controllable and appears in the audit intro.
- **Props interface** — all props, types, and union/boolean values
- **Visual vs. behavior props** — focus on visual ones for Figma; ignore `onPress`, `testID`, `tKey`
- **Color tokens** — check both sources:
  1. **Semantic Tailwind classNames (preferred):** NativeWind `className` values like `bg-surface-*`, `text-fg-*`, `fill-fg-*`, `border-border-*`, `bg-brand-*`. These map to semantic Figma variables — see the token table in `references/btmobile-design-system.md`.
  2. **Raw `useTheme()` palette tokens:** `colors.*` values (e.g. `colors.gray90`). Cross-reference the semantic table — if a semantic equivalent exists, use it and note the gap in the audit. If no match, use the palette variable directly.
  - If any color is a native OS default (no value set in code) → leave unset in Figma; document as native default in the audit.
- **Layout values** — extract padding, gap, border radius, border width, sizing from `className`
- **Typography** — which Tailwind classes are used (`heavy-*`, `distinct-*`, `normal-*`); these map to Figma text styles
- **Icons** — which icons are used per variant; note the icon name
- **States** — Default, Active, Disabled, Loading, etc.
- **Repeating sub-elements** — look for:
  - Sub-elements rendered via `.map()` or iteration
  - Sub-elements with their own variant logic (selected/unselected, disabled, size variants)
  - Visually distinct parts with independent props or state
  - Named internal components in the source

  **Rule of thumb:** if the same visual element is instantiated more than once within the parent, it should be its own base component in Figma. Note these for Step 5.

**If resuming from a compressed/summarized context, re-read the source file before building.** Summaries lose fine-grained detail — always verify from the live source.

---

## Step 2 — Determine variants and properties

Map props to Figma component properties:

- **Boolean props** → Boolean property (e.g. `disabled?: boolean` → `Disabled=True/False`)
- **Union string props** → Variant property (e.g. `variant: 'primary' | 'secondary'` → `Variant=Primary, Secondary`)
- **Text content props** (label, title, children as string) → Text property
- **Icon props** (`React.ReactNode`, `ComponentType`, or an icon name) → Instance-swap property — see icon workflow in Step 6
- **Configurable icon slots** (any icon can be slotted by the caller): use the **Add** icon from Blueprint Base as a placeholder. Note the substitution in the audit and the session summary (Step 12).
- Ignore behavior-only props (`onPress`, `testID`, `tKey`)

---

## Step 3 — Identify the Figma target and mode

- If the user provided a Figma link to a specific component or node, extract the `fileKey` and `nodeId` from the URL. This is **edit mode**.
- Otherwise, use the main Mobile Design System file. First switch to the component's page (named after the component), then search for an existing component set:

  ```javascript
  const targetPage = figma.root.children.find((p) => p.name === "BTMyComponent");
  if (targetPage) await figma.setCurrentPageAsync(targetPage);
  const match = figma.currentPage.findOne(
    (n) => n.type === "COMPONENT_SET" && n.name === "BTMyComponent",
  );
  return { found: !!match, pageExists: !!targetPage, id: match?.id, x: match?.x, y: match?.y };
  ```

  - If found → **edit mode**
  - If not found → **create mode**

The Figma page should be named the same as the component (e.g. `BTBanner`). **For native-only components** (no RN source found in Step 1), append `(Native)` to the page name (e.g. `Bottom Nav (Native)`).

**Page creation:** If the user provided a Figma URL, use that page directly. If no URL was provided and no matching page exists, create it without asking — note the page creation in the session summary (Step 12).

**Page name correction and alphabetization (required):** Once you have identified the target page, check whether its name exactly matches the component name. If it does not (e.g. the page is named `Accordion` but the component is `BTAccordion`, or `Select` but the component is `BTGroupedSelectField`), rename it and re-alphabetize the component section — both in a single `use_figma` call, before building anything.

**Do not skip this step** even if the page appears to cover multiple related components (e.g., "Select" could seem like a family page for all select variants). Each Figma page maps to exactly one component. Existing content on the page stays intact — only the page name changes. If you are genuinely unsure whether a page rename is safe, flag it to the user before proceeding. **Never silently skip the rename.**

```javascript
// 1. Rename the page
const page = figma.root.children.find((p) => p.id === "PAGE_ID");
page.name = "BTComponentName"; // use the exact BT-prefixed component name

// 2. Re-alphabetize: find the bounds dynamically — no hardcoded indices
const allPages = [...figma.root.children];
const startIdx = allPages.findIndex((p) => p.name === "🧩 COMPONENTS 🧩") + 1;
const endIdx = allPages.findIndex((p, i) => i > startIdx && p.name === "---");
const componentPages = allPages.slice(startIdx, endIdx);
componentPages.sort((a, b) =>
  a.name.toLowerCase().localeCompare(b.name.toLowerCase()),
);
for (let i = componentPages.length - 1; i >= 0; i--) {
  figma.root.insertChild(startIdx, componentPages[i]);
}
```

**Inspecting an existing node by URL:**

Use `get_metadata` with the `nodeId` and `fileKey` to get the node's name, type, position, and page. Use `get_screenshot` with the `nodeId` and `fileKey` to get a visual of the existing component.

**Reference mockups:** If the page contains loose frames or annotated mockups that are not a component set, keep them intact. Note their presence in the "Figma Component" section of the audit (e.g. "The page also contains reference mockups showing states from a prior design pass — these have been preserved.").

---

## Step 4 — Find icons and section fill variable in Blueprint Base

Use `search_design_system` (first-party Figma MCP) to find Blueprint Base icon components by name. You do not need Blueprint Base open in any plugin — this MCP searches published libraries directly.

**This step is the same regardless of create or edit mode.** Start by identifying which icons the component needs (from Step 1). If an existing component set is already on the page, check which icons are already present and correctly bound — import only what is missing or incorrectly mapped.

- Icon names generally match between BTMobile and Blueprint Base, but not always. Known mismatch: BTMobile `Close` → Blueprint Base `X`.
- For React Navigation platform elements (e.g. the back button chevron from `HeaderBackButton`): use the closest Blueprint Base substitute (e.g. `CaretLargeLeft`) and note it in the audit.
- If an icon cannot be found in Blueprint Base at all, generate an SVG placeholder, note it in the audit, and include it in the session summary (Step 12).
- Record each icon's component key for use in Step 6.

**Also import the section fill variable and Confluence link color from Blueprint Base** — sections use `color/gray/10` and the Confluence link uses `color/blue/70`, both from the Global Tokens collection. Import them at the same time as icons since they're in the same file:

```javascript
const libCollections = await figma.teamLibrary.getAvailableLibraryVariableCollectionsAsync();
const base = libCollections.find(c => c.libraryName === 'Blueprint Base' && c.name === 'Global Tokens');
const libVars = await figma.teamLibrary.getVariablesInLibraryCollectionAsync(base.key);
const grayTen = libVars.find(v => v.name === 'color/gray/10');
const sectionFillVar = await figma.variables.importVariableByKeyAsync(grayTen.key);
// Store sectionFillVar.id — use it in Step 11 to bind section fills
const blueSeventy = libVars.find(v => v.name === 'color/blue/70');
const confluenceLinkColorVar = await figma.variables.importVariableByKeyAsync(blueSeventy.key);
// Store confluenceLinkColorVar.id — use it in Step 10 to bind the Confluence link text color
```

---

## Step 5 — Ensure base components exist

If Step 1 identified repeating sub-elements, ensure a base component exists for each one before building the parent. Check the "Building blocks" section of the page first:

- **If a base component already exists:** verify its structure matches the current source. Update variants, token bindings, or layout if needed.
- **If it doesn't exist yet:** create it with `figma.createComponent()`, add variants if the element has states, and prefix the name with an underscore.
- **While reviewing an existing component set:** if you notice a visual state or sub-element that is logically distinct but not yet broken out as a building block — and factoring it out would make the component cleaner — create the base component now and wire it in. Note the addition in the audit.

These live in the **"Building blocks"** section when organized in Step 11 — not the "Component" section. For now, build them on the canvas.

```js
// Example: an "_Item" base component for an accordion
const itemComp = figma.createComponent();
itemComp.name = "_BTAccordion_Item";
// Set up auto-layout, text, variant properties
return { success: true, itemComponentKey: itemComp.key };
```

Build the parent in Step 6 using instances of these base components — do not duplicate their structure manually.

---

## Step 6 — Build or update the Figma component

Use `use_figma` with the Figma Plugin API. Follow all rules below.

### Async API rules (non-negotiable)

- `await figma.setCurrentPageAsync(page)` — never `figma.currentPage = page`
- `await figma.getNodeByIdAsync(id)` — never `figma.getNodeById(id)` after a page switch
- `await figma.variables.getLocalVariablesAsync()` — never the sync version
- `await figma.variables.getLocalVariableCollectionsAsync()` — never the sync version
- `await figma.getLocalTextStylesAsync()` — never the sync version

### Build process

1. Take a screenshot of the target page first to understand the current state and find clear space.
2. **Ensure the component set name matches the code name exactly** (e.g. `BTBanner`, not `Banner`). If it doesn't, rename it before making other changes and note the correction.
3. If base components exist from Step 5, use them as instances when assembling variants — do not duplicate their structure manually.
4. **Ensure all variants from the current props interface are present.** Add any that are missing. Do not remove existing variants unless they clearly no longer map to any prop value — ask the user first if unsure.
5. **Ensure component properties match the current props interface.** Add or update as needed.
6. Name each variant using `Property=Value, Property=Value` format.
7. Name the component set to match the BTMobile component name exactly (e.g. `BTBanner`, `BTButton`). **For native-only components**, append ` (Native)` to the component set name (e.g. `Bottom Nav (Native)`).
8. **For components at the bottom edge of the screen** (tab bars, bottom toolbars): set `paddingBottom: 34` to account for the iPhone home indicator safe area (total height = content height + 34pt, e.g. 49pt content + 34pt = 83pt total).
9. When creating new variants: combine with `figma.combineAsVariants(allComponents, page)` — then immediately run the grid layout pass below.
10. After each `use_figma` call, take a screenshot and verify:
    - All variant axes represented and readable
    - Alignment, spacing, and visual balance match the Storybook
    - No overlapping nodes
11. Iterate up to 3 times to fix issues, then take a final verification screenshot.

### Grid layout pass (required after `combineAsVariants`)

`combineAsVariants` stacks all children at (0,0). Run this immediately after combining:

```javascript
const GAP = 20;
const ROWS = /* number of inner-loop values (e.g. states) */;
const COLS = /* total variants / ROWS */;

const colWidths = new Array(COLS).fill(0);
set.children.forEach((child, i) => {
  const col = Math.floor(i / ROWS);
  colWidths[col] = Math.max(colWidths[col], child.width);
});

const colX = [];
let cx = GAP;
for (let c = 0; c < COLS; c++) { colX.push(cx); cx += colWidths[c] + GAP; }

const rowH = set.children[0].height;
set.children.forEach((child, i) => {
  child.x = colX[Math.floor(i / ROWS)];
  child.y = GAP + (i % ROWS) * (rowH + GAP);
});

set.resizeWithoutConstraints(cx, GAP + ROWS * (rowH + GAP));
figma.viewport.scrollAndZoomIntoView([set]);
```

### Color tokens

**Only use variables from the Mobile Design System's local "Semantic aliases" collection.** Do not attempt to bind Blueprint Base variables — Blueprint Base is the BTNet/web design system (Blueprint Production Figma file) and is not used in the MDS. The "Blueprint Base variable" column in the color resolution audit table is cross-platform reference documentation only, not a binding target.

**When updating an existing component:** call `figma.variables.getVariableByIdAsync()` on existing fills and strokes to discover which MDS variables are already bound — replicate those bindings where they are correct rather than re-sourcing everything from scratch.

Bind every fill and stroke to an MDS variable using `figma.variables.setBoundVariableForPaint()`. Do not hardcode hex values — except for explicitly set values with no matching token. Do not create separate dark mode variants — BTMobile color variables have both Light and Dark modes built in.

**Two-path mapping:**

1. **Semantic className → semantic MDS variable (preferred):**

   ```javascript
   const vars = await figma.variables.getLocalVariablesAsync();
   const token = vars.find((v) => v.name === "fg/secondary");
   node.fills = node.fills.map((fill) =>
     fill.type === "SOLID"
       ? figma.variables.setBoundVariableForPaint(fill, "color", token)
       : fill,
   );
   ```

2. **Raw `useTheme()` token → check semantic table first.** If a semantic equivalent exists, use it and document the gap. If not, use the palette variable:
   ```javascript
   const token = vars.find((v) => v.name === "typography/950");
   ```

**Native OS defaults:** Leave unset. Note in the audit which properties were left unset and why.

**States where code has no visual styling — apply design convention instead of following code literally.** Some props (like `isReadOnly`) make a field non-editable in code without any visual change (no color, no background). Do not carry that "no visual change" into Figma — apply the standard design convention so the state is visually distinguishable:

| State | Background | Text color | Border | Notes |
|---|---|---|---|---|
| ReadOnly | `surface/secondary` | `fg/default` | `border/default` | Grey bg signals non-editable; dark text keeps it readable |
| Disabled | `surface/disabled` | `fg/on-disabled` | `border/disabled` | Both bg and text dimmed — fully non-interactive |

If you encounter a prop with no visual code-level treatment, check design convention first, then flag the code/design gap in the audit.

See `references/btmobile-design-system.md` for the full token-to-variable mapping tables.

### Typography

```javascript
const styles = await figma.getLocalTextStylesAsync();
const style = styles.find((s) => s.name === "distinct/sm");
textNode.textStyleId = style.id;
```

Apply text styles for any text the component explicitly controls (font weight, font size, or font family). If the component only controls color without a font size, bind the color variable only — do not apply a text style.

### Icons

Import Blueprint Base icons by key (from Step 4):

```javascript
const icon = await figma.importComponentByKeyAsync(key);
const instance = icon.createInstance();
```

Bind icon fills to the appropriate color variable using `setBoundVariableForPaint()`. If the correct token is uncertain, keep the default and note it in the audit.

---

## Step 7 — Ensure page background color

Check the current page background. If it is not already set to the MDS dark canvas color (`#1E1E1E`), set it. This applies in both create mode and edit mode.

```javascript
const targetPage = figma.root.children.find((p) => p.name === "PageName");
await figma.setCurrentPageAsync(targetPage);
figma.currentPage.backgrounds = [{
  type: "SOLID",
  color: { r: 0x1E / 255, g: 0x1E / 255, b: 0x1E / 255 },
}];
```

---

## Step 8 — Validate

After creating or updating the component, take a screenshot and verify:

- All variants are present and correctly named
- No hardcoded color values remain (except documented native defaults)
- Text styles are applied where appropriate
- Auto-layout is applied at every level
- Text node centering: for any text node inside a fixed-height frame with `layoutMode: NONE`, verify `y === Math.round((frameHeight - textHeight) / 2)`. Fix off-center text nodes before proceeding.

---

## Step 9 — Write the Confluence gap audit (only if changes were made)

**Skip this step entirely if no changes were made to the Figma component.** Only proceed if this run resulted in actual changes to the Figma file — including any of:

- New nodes created (components, variants, text)
- Variable bindings added or updated (token rebinding counts)
- Text styles applied or corrected
- Structural changes (components moved, layout fixed)
- Figma page or component set renamed

Section-only housekeeping (e.g. moving existing components into a section with no other edits) does **not** count — skip in that case. If skipped, also skip Step 10.

### Page title

`[ComponentName] Gap Audit`

Use the exact component name as it appears in code (e.g. `BTBanner Gap Audit`, `BTButton Gap Audit`). Always use the BT-prefixed class name, not a generic common name. **For native-only components**, append `(Native)`: e.g. `Bottom Nav Gap Audit (Native)`.

### Parent page

- Space: `UX`
- Parent page ID: `6640009227` (`RN component audit`)
- **Check for an existing page with the same title first — update it rather than creating a duplicate**
- When creating a new page, check the existing child pages under `6640009227` to understand the current structure before adding

### Page structure

```
[Intro paragraph: what the audit covers, the component's implementation type
(Gluestack-wrapped / fully custom / 3rd-party library wrapper), and source files referenced.
For non-standard implementations, explain what it wraps and what that means for styling.]

_Source: [file paths]. Audit generated via MCP on [today's date]._

## What [ComponentName] Defines

### Variant axes
| Prop | Values |

### Color resolution
_Note: The "Blueprint Base variable mapped" and "Blueprint Base resolved hex" columns are cross-platform reference documentation only — they show the conceptual BDS equivalent for each token. They are not binding targets. Figma variable bindings in the MDS component use MDS local "Semantic aliases" variables only._

| Action/element | BTMobile semantic token | Resolved hex | Blueprint Base variable mapped | Blueprint Base resolved hex |

### Layout spec
| Property | NativeWind class | Value | BDS token used |

### Typography
| Element | NativeWind/RN class | Weight | BDS text style mapped |

### Icons
| Slot / variant | RN icon / source | Blueprint Base component | Notes |

## What Blueprint Base Defines
[Narrative summary of relevant token collections — what's present and absent for this component]

## Gaps
### 1. [Gap title]
[Description. Who's affected. What needs to change.]
**Owner:** [BDS | BTMobile | Documentation | BDS (Blueprint Base) | BDS (token package)]

[repeat for each gap]

## Figma Component
[Where the component set lives: page name, file name, variant count]

## Summary
| Gap | Affected side | Severity |
```

### Severity scale

- **Low** — visual impact minimal or standard convention gap
- **Medium** — visible inconsistency or token governance issue
- **High** — breaks theming, accessibility, or cross-platform parity

### Owner tags

- `BDS` — Buildertrend Design System team
- `BDS (Blueprint Base)` — gap in the Blueprint Base Figma file specifically
- `BDS (token package)` — gap in the `@buildertrend/design-tokens` package
- `BTMobile` — mobile engineering or the Mobile Design System Figma file
- `Documentation` — no code change needed; requires a callout in usage notes

### Confluence API (Atlassian Rovo MCP)

Search for an existing page first:

- Use `searchConfluenceUsingCql` with a **fuzzy** CQL query (`~` not `=`) so partial title matches are found (e.g., "Bottom Nav Gap Audit" should match "Bottom Nav Gap Audit (Native)")
- If found: **before updating**, call `getConfluencePage` to fetch the current full body content. Make targeted in-place edits — find the specific rows, values, or sentences that need updating and change only those. Never do a full rewrite. Reorganizing the structure of a section is fine if it improves clarity, but content unrelated to the current changes must remain untouched. Pass the complete page body — with only the targeted changes applied — when calling `updateConfluencePage`. Omitting or truncating the body will silently overwrite and destroy existing content.
- If not found: use `createConfluencePage` with `spaceId: 374440261`, `parentId: 6640009227`

---

## Step 10 — Add Confluence link below the component in Figma

After the Confluence page is created or updated, ensure a hyperlinked "Confluence page" text node exists below the component set.

**First, check if one already exists** — search the page for a TEXT node whose `characters` value is `"Confluence page"`:

- **If found:** check whether its hyperlink URL matches the current Confluence page URL. If it differs, update the URL. If it already matches, leave it unchanged.
- **If not found:** create it using the code below.

```javascript
const text = figma.createText();
await figma.loadFontAsync({ family: "Inter", style: "Regular" });
text.characters = "Confluence page";
text.hyperlink = { type: "URL", value: "[confluence page URL]" };
text.textDecoration = "UNDERLINE";
text.fontSize = 14;
text.lineHeight = { value: 20, unit: "PIXELS" };
// Bind fill to color/blue/70 imported from Blueprint Base in Step 4
const confluenceLinkColorVar = await figma.variables.getVariableByIdAsync(confluenceLinkColorVarId);
text.fills = [figma.variables.setBoundVariableForPaint(
  { type: "SOLID", color: { r: 0, g: 0, b: 0 } },
  "color",
  confluenceLinkColorVar
)];
text.x = componentSet.x;
text.y = componentSet.y + componentSet.height + 32;
componentSet.parent.appendChild(text);
```

**Placement is fixed — not a decision:** `x = componentSet.x`, `y = componentSet.y + componentSet.height + 32`. Do not log this as an autonomous decision in the session summary. Use the actual Confluence page URL returned from the create or update call.

---

## Step 11 — Organize into sections

Two sections are used per component page:

- **"Component"** — the main assembled component set (e.g. `BTBanner`, `Bottom Nav`) and its Confluence link text node
- **"Building blocks"** — underscore-prefixed sub-components (e.g. `_Tab Item`, `_BTAccordion_Item`) that are building blocks used inside the main component

**Layout:** Place the "Component" section on the **left** and the "Building blocks" section on the **right**, with a **140px gap** between them. Use the component set's bounding box to determine the Component section width, then position Building blocks at `componentSection.x + componentSection.width + 140`.

For each section:
1. Check if a section with that name already exists on the page
2. If absent, create it: `const section = figma.createSection(); section.name = "Component";`
3. Move the relevant nodes into it — component set + Confluence link text node go into "Component"; base component sets go into "Building blocks". **The Confluence link must be moved together with the component set**, not left floating on the canvas.
4. Bind the section fill to the `color/gray/10` variable imported from Blueprint Base in Step 4:
   ```javascript
   const sectionFillVar = await figma.variables.getVariableByIdAsync(sectionFillVarId);
   section.fills = [figma.variables.setBoundVariableForPaint(
     { type: 'SOLID', color: { r: 1, g: 1, b: 1 } },
     'color',
     sectionFillVar
   )];
   ```
5. If a section already exists, verify its fill is bound to `color/gray/10` — update if missing or hardcoded
6. **Always verify and fix section positions** — this applies in both create mode AND edit mode, even when sections already existed before this run:
   - "Component" must be the leftmost section
   - "Building blocks" must be at `componentSection.x + componentSection.width + 140`
   - Both sections must share the same `y`
   - Fix positions if any of these conditions are not met

Only create the "Building blocks" section if underscore-prefixed sub-components exist. The "Component" section is always required.

After organizing, take a final screenshot to confirm both sections are present, correctly populated, and correctly positioned side-by-side.

---

## Step 12 — Pre-summary verification

Silently verify every mandatory step was completed. Do not output the checklist table to chat — just check each item internally and go back to complete any that were skipped before proceeding. Only move to Step 13 once all items pass.

| Step | Check |
|------|-------|
| 3 — Component created or updated | ✓ |
| 7 — Page background set to `#1E1E1E` | ✓ |
| 9 — Confluence page created or updated | ✓ |
| 10 — Confluence link text node present in Figma | ✓ |
| 11 — Sections organized, both fills bound to `color/gray/10` | ✓ |

---

## Step 13 — Session summary

Post a summary message in chat covering everything that happened during the run. This is separate from the Confluence audit — it's a run report for you to review.

Include:

**What was built or changed**
- Component name, variant count, and mode (create or edit)
- Whether a page was created vs. an existing page used

**Autonomous decisions made**
Any decision you made without asking — list each one so it's visible for review:
- Page created without confirmation (note the page name)
- Placeholder icon used (note which slot and which icon was substituted)
- SVG generated for a missing icon (note icon name and affected slot)
- Add icon used for a configurable slot (note the prop name)
- Design convention applied where code had no visual treatment (e.g. ReadOnly state)
- Any token left unset because it was a native OS default

**Links**
- Confluence audit page URL
- Figma page link (direct link to the component page)

**Follow-up flags** (if any)
Anything that needs attention but wasn't blocking — e.g., an icon mismatch noted in the audit, a token gap the engineering team should address, or a Storybook story that didn't exist.

---

## Key references

- BTMobile repo: `$BTMOBILE_PATH` (prompted at session start, default `~/Dev/BTMobile`)
- Component source: `$BTMOBILE_PATH/packages/core/ui/components/`
- Storybook stories: `$BTMOBILE_PATH/apps/storybook/src/Components/`
- Figma build target: Mobile Design System (React Native) — always the same file (`IRwit3I589T9ax0fQM9cCj`), page named after the component
- Token + typography reference: `references/btmobile-design-system.md`
- Confluence space: `UX` / space ID: `374440261`
- Confluence parent: `RN component audit` — page ID `6640009227`
- Confluence root doc: `https://btwiki.atlassian.net/wiki/x/C4DGiwE`

