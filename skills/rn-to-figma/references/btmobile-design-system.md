# BTMobile Design System Reference

## Figma File
- **Main file**: https://www.figma.com/design/IRwit3I589T9ax0fQM9cCj/Mobile-Design-System--React-Native-
- If the user provides a Figma link (including a branch or specific node), always use that link instead.

## Component Location in Repo
- Components: `/packages/core/ui/components/`
- Theme colors: `/packages/core/ui/theme/LightColors.ts` and `DarkColors.ts`
- Typography + color tokens: `/packages/core/ui/tailwind-preset.js`

## Color Token Collections (Figma Variables)

BTMobile has two color layers. **Prefer semantic tokens** when building Figma components. Use palette tokens only for components that have no semantic equivalent (e.g., raw Gluestack palette usage).

---

### Semantic color tokens (preferred)

Source of truth: `packages/core/ui/tailwind-preset.js`.

These are used via Tailwind `className` in code (e.g. `bg-surface`, `text-fg-secondary`).

**To find the Figma variable name:** use `figma.variables.getLocalVariablesAsync()` and search for the token key (e.g. `surface/hover`, `fg/secondary`). The Figma variable names follow the same key structure as the Tailwind entries below (forward-slash separated) — with one exception: Tailwind uses uppercase `DEFAULT` for the top-level value of a group, but the Figma variables use lowercase `default` (e.g. `fg/default`, `surface/default`).

#### `surface` — background fills

| Tailwind className | Palette resolves to | Figma variable (search key) |
|--------------------|--------------------|-----------------------------|
| `bg-surface` | gray-0 | `surface/default` |
| `bg-surface-hover` | gray-5 | `surface/hover` |
| `bg-surface-pressed` | gray-10 | `surface/pressed` |
| `bg-surface-secondary` | gray-10 | `surface/secondary` |
| `bg-surface-secondary-hover` | gray-15 | `surface/secondary/hover` |
| `bg-surface-secondary-pressed` | gray-20 | `surface/secondary/pressed` |
| `bg-surface-selected` | blue-10 | `surface/selected` |
| `bg-surface-selected-hover` | blue-15 | `surface/selected/hover` |
| `bg-surface-selected-pressed` | blue-20 | `surface/selected/pressed` |
| `bg-surface-primary` | blue-70 | `surface/primary` |
| `bg-surface-primary-hover` | blue-80 | `surface/primary/hover` |
| `bg-surface-primary-pressed` | blue-90 | `surface/primary/pressed` |
| `bg-surface-primary-subtle` | blue-20 | `surface/primary/subtle` |
| `bg-surface-error` | red-70 | `surface/error` |
| `bg-surface-error-subtle` | red-10 | `surface/error/subtle` |
| `bg-surface-warning` | yellow-70 | `surface/warning` |
| `bg-surface-warning-subtle` | yellow-10 | `surface/warning/subtle` |
| `bg-surface-success` | green-70 | `surface/success` |
| `bg-surface-success-subtle` | green-10 | `surface/success/subtle` |
| `bg-surface-info` | blue-70 | `surface/info` |
| `bg-surface-info-subtle` | blue-10 | `surface/info/subtle` |
| `bg-surface-disabled` | gray-5 | `surface/disabled` |

#### `fg` — foreground / text / icon fills

| Tailwind className | Palette resolves to | Figma variable (search key) |
|--------------------|--------------------|-----------------------------|
| `text-fg` / `fill-fg` | gray-90 | `fg/default` |
| `text-fg-secondary` / `fill-fg-secondary` | gray-70 | `fg/secondary` |
| `text-fg-tertiary` / `fill-fg-tertiary` | gray-60 | `fg/tertiary` |
| `text-fg-primary` / `fill-fg-primary` | blue-70 | `fg/primary` |
| `text-fg-primary-hover` | blue-80 | `fg/primary/hover` |
| `text-fg-primary-pressed` | blue-90 | `fg/primary/pressed` |
| `text-fg-link` | blue-70 | `fg/link` |
| `text-fg-link-visited` | blue-80 | `fg/link/visited` |
| `text-fg-on-primary` / `fill-fg-on-primary` | gray-0 | `fg/on-primary` |
| `text-fg-error` / `fill-fg-error` | red-70 | `fg/error` |
| `text-fg-on-error` | gray-0 | `fg/on-error` |
| `text-fg-warning` | yellow-70 | `fg/warning` |
| `text-fg-success` | green-70 | `fg/success` |
| `text-fg-info` | blue-70 | `fg/info` |
| `text-fg-disabled` | gray-40 | `fg/disabled` |
| `text-fg-on-disabled` | gray-60 | `fg/on-disabled` |

#### `border` — stroke / border fills

| Tailwind className | Palette resolves to | Figma variable (search key) |
|--------------------|--------------------|-----------------------------|
| `border-border` | gray-20 | `border/default` |
| `border-border-disabled` | gray-15 | `border/disabled` |
| `border-border-focus` | blue-50 | `border/focus` |
| `border-border-error` | red-50 | `border/error` |
| `border-border-success` | green-50 | `border/success` |
| `border-border-warning` | yellow-70 | `border/warning` |
| `border-border-info` | blue-70 | `border/info` |

#### `brand` — brand identity fills

| Tailwind className | Palette resolves to | Figma variable (search key) |
|--------------------|--------------------|-----------------------------|
| `bg-brand-primary1` | blue-90 | `brand/primary1` |
| `bg-brand-primary2` | teal-40 | `brand/primary2` |
| `bg-brand-secondary1` | red-50 | `brand/secondary1` |
| `bg-brand-secondary2` | orange-25 | `brand/secondary2` |
| `bg-brand-secondary3` | blue-60 | `brand/secondary3` |

---

### Palette color tokens (raw)

Used for `useTheme()` values (e.g. `colors.gray90`, `colors.background0`) and raw Gluestack palette usage. Also present in the Figma file as variables.

| Collection | Semantic role | Tailwind prefix |
|------------|--------------|-----------------|
| Primary    | Brand blue   | `primary-*`     |
| Secondary  | Teal         | `secondary-*`   |
| Tertiary   | Orange       | `tertiary-*`    |
| Error      | Red          | `error-*`       |
| Success    | Green        | `success-*`     |
| Warning    | Yellow       | `warning-*`     |
| Info       | Indigo       | `info-*`        |
| Outline    | Gray (borders/outlines) | `outline-*` |
| Background | Gray (surfaces) | `background-*` |
| Typography | Neutral text scale | `typography-*` |
| Indicator  | primary, info, error only | `indicator-*` |

Steps: `0, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950`

#### Mapping raw useTheme() palette tokens to Figma variables
- `colors.typography950` → variable `typography/950`
- `colors.typography700` → variable `typography/700`
- `colors.primary500` → variable `primary/500`
- `colors.background0` → variable `background/0`
- `colors.gray90` → variable `gray/90` (raw) — but check semantic table first: `colors.gray90` = gray-90 = `fg/DEFAULT`
- camelCase in code maps directly to slash-separated in Figma

#### When to use palette vs semantic in Figma
- Code uses a semantic Tailwind className (`bg-surface`, `text-fg-secondary`) → use the **semantic** Figma variable from the table above.
- Code uses a raw `useTheme()` palette token (`colors.gray90`, `colors.background0`) → cross-reference the palette tables above to find if a semantic equivalent exists. **If a semantic match exists, use the semantic Figma variable and note the gap in the audit** (e.g. "code uses `colors.gray90` via `useTheme()` — no semantic className available; Figma uses `fg/DEFAULT` as semantic equivalent"). **If no semantic match, use the palette Figma variable directly.**
- A color is a native OS default (no token set in code) → leave unset in Figma; document as native default in the audit.

## Typography Text Styles (Figma)

All 10 styles are defined in the BTMobile Figma file. These match `tailwind-preset.js` exactly.

| Style name   | Font           | Weight          | Size | Line height |
|--------------|----------------|-----------------|------|-------------|
| `heavy/xl`   | GT Walsheim    | Black (900)     | 42px | 48px        |
| `heavy/lg`   | GT Walsheim    | Black (900)     | 34px | 44px        |
| `heavy/md`   | GT Walsheim    | Bold (700)      | 30px | 36px        |
| `heavy/sm`   | GT Walsheim    | Bold (700)      | 24px | 32px        |
| `distinct/lg`| Inter          | Semi Bold (600) | 20px | 24px        |
| `distinct/md`| Inter          | Semi Bold (600) | 16px | 24px        |
| `distinct/sm`| Inter          | Medium (500)    | 14px | 20px        |
| `normal/lg`  | Inter          | Regular (400)   | 16px | 24px        |
| `normal/md`  | Inter          | Regular (400)   | 14px | 20px        |
| `normal/sm`  | Inter          | Regular (400)   | 12px | 16px        |

### Choosing the right text style
- Labels on interactive elements → `distinct/sm` or `distinct/md`
- Body/supporting text → `normal/sm`, `normal/md`, `normal/lg`
- Headings/screen titles → `heavy/sm` through `heavy/xl`
- If the component specifies no font size (e.g. native control default ~13px) → bind color token only, do not apply a text style

## Figma API Patterns (via use_figma)

### Bind a color variable to a fill
```javascript
const vars = await figma.variables.getLocalVariablesAsync();
const token = vars.find(v => v.name === 'typography/950');
node.fills = node.fills.map(fill =>
  fill.type === 'SOLID'
    ? figma.variables.setBoundVariableForPaint(fill, 'color', token)
    : fill
);
```

### Apply a text style
```javascript
const styles = await figma.getLocalTextStylesAsync();
const style = styles.find(s => s.name === 'distinct/sm');
textNode.textStyleId = style.id;
```

### Create a component set with variants
```javascript
const comp1 = figma.createComponent();
comp1.name = 'State=Default';
const comp2 = figma.createComponent();
comp2.name = 'State=Pressed';
const set = figma.combineAsVariants([comp1, comp2], figma.currentPage);
set.name = 'BTMyComponent';
```

### Import a Blueprint Base library variable
```javascript
const libCollections = await figma.teamLibrary.getAvailableLibraryVariableCollectionsAsync();
const globalTokens = libCollections.find(c => c.libraryName === 'Blueprint Base' && c.name === 'Global Tokens');
const libVars = await figma.teamLibrary.getVariablesInLibraryCollectionAsync(globalTokens.key);
const targetVar = libVars.find(v => v.name === 'color/blue/90');
const imported = await figma.variables.importVariableByKeyAsync(targetVar.key);
```

### Always use async APIs
- `figma.variables.getLocalVariablesAsync()` not `getLocalVariables()`
- `figma.variables.getLocalVariableCollectionsAsync()` not `getLocalVariableCollections()`
- `figma.getLocalTextStylesAsync()` not `getLocalTextStyles()`
- `figma.getNodeByIdAsync(id)` not `figma.getNodeById(id)`
