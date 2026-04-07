# Blueprint Design System — Figma Make Guidelines

Use Blueprint Design System (BDS) components and tokens for everything. Never fall back to generic defaults.

---

## Typography

Use this hierarchy exactly. Do not substitute sizes.

| Role | Style |
|---|---|
| Page or modal title | Heavy / XL |
| Page subtitle or supporting description | Regular / LG |
| Section heading | Heavy / LG |
| Form field label (above an input) | Distinct / SM — never Regular |
| Body text | Regular / MD |
| Caption or helper text | Regular / SM |

Font families: **Whyte** for display, **Inter** for body, **Roboto Mono** for code.

---

## Spacing

All spacing is in multiples of 4px. Use these token values:

`025` = 1px · `05` = 2px · `1` = 4px · `2` = 8px · `3` = 12px · `4` = 16px · `5` = 20px · `6` = 24px · `8` = 32px · `10` = 40px · `12` = 48px · `16` = 64px

---

## Colors

Token pattern: `--color-{category}-{role}-{prominence}-{interaction}`

Categories: `bg` · `text` · `icon` · `border` · `gauge`

When placing content on a semantic background (brand, danger, success, warning), use the matching `on-` content token (e.g. `--color-text-on-brand`).

---

## Buttons

Use BDS buttons for all interactive actions.

| Type | Appearance | When to use |
|---|---|---|
| Primary | Filled, brand color | The single most important action on the page. One per view. |
| Secondary | Outlined | Prominent but not the main action. Filter, Export, Cancel. |
| Tertiary | Ghost / no border | Low-attention utility actions. Never use for navigation links or sign-up prompts. |
| Danger | Filled, red | Destructive, hard-to-reverse actions. Delete, Disconnect, Void. |
| Secondary Danger | Outlined, red | Destructive actions in overflow menus only. |

**Rules:**
- Never use more than one primary button per view.
- Icon-only buttons always need a tooltip.
- "Forgot password?" and "Sign up" style links should appear as **inline text links**, not tertiary buttons — they must be clearly readable as actions without a button shape.

---

## Form Fields

- Labels above inputs use **Distinct / SM** weight — heavier than body text so they read as labels.
- All text inputs use `BdsInput`. Never use a plain HTML input.
- All dropdowns use `BdsSelect`.
- Checkboxes use `BdsCheckbox`. Keep the label short — it should never wrap to a second line. If a label is long, rewrite it to be concise.
- Radio buttons use `BdsRadioGroup` when only one option can be selected. Use for 2–5 choices. More than 5 → use a select.

---

## Layout

Use BDS layout components — not custom CSS grids or flexbox.

| Component | Use for |
|---|---|
| `BdsLayout` | Page-level structure. Use `displayType` templates: `"HCF"` (Header/Content/Footer), `"1and1"`, `"1and2"`, `"sidebar"`, etc. |
| `BdsRow` | Horizontal flex rows within a section. |
| `BdsCol` | Vertical flex columns within a section. |
| `BdsSection` | Primary content container on a page. Supports title, status badge, and action slot. |
| `BdsPanel` | List + detail split views. |

---

## Status & Labels

- Use `BdsBadge` for status labels (success, warning, danger, info). Never use a plain `<span>` or custom chip.
- Use `BdsPill` for compact, removable, or selectable tags.

Badge display types: `default` · `info` · `warning` · `danger` · `success`

---

## Empty States

When a list or content area has no data:

1. Show a feature icon
2. Short header: **"Add [a] [item name]"**
3. 1–2 lines of plain-language explanation (educate, don't upsell)
4. Do not include a primary action button if one already exists in the page header

Empty state types: Onboarding · Structural · Temporary · Permissions · Error · Search/filter

---

## Writing & Content

- Active voice: "We couldn't find that." Not "That couldn't be found."
- Contractions: can't, don't, isn't.
- Second person: "you," not "my."
- No exclamation points. No emojis.
- No periods on short labels or single-sentence strings.
- Sentence case for labels — not Title Case.
- Oxford comma: "Add, edit, and approve."
- Use "select" or "choose" — not "click" or "tap."

| Avoid | Use instead |
|---|---|
| Activate / enable | Turn on |
| Deactivate / disable | Turn off |
| Configure | Set up / edit |
| Display | Show |
| Input | Enter |
| Modify | Edit |
| Submit | Send |
| Utilize | Use |
| Purchase | Buy |
