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

Font families: **GT Walsheim** for display, **Inter** for body.

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

Use `BuiButton` for all interactive actions.

| Type | Appearance | When to use |
|---|---|---|
| Primary | Filled, brand color | The single most important action on the page. One per view. |
| Secondary | Outlined | Prominent but not the main action. Filter, Export, Cancel. |
| Tertiary | Ghost / no border | Low-attention utility actions. Never use for navigation links or sign-up prompts. |
| Danger | Filled, red | Destructive, hard-to-reverse actions. Delete, Disconnect, Void. |
| Secondary Danger | Outlined, red | Destructive actions in overflow menus only. |

**Rules:**
- Never use more than one primary button per view.
- Icon-only buttons always need a tooltip and an accessible label.
- "Forgot password?" and "Sign up" style links should appear as **inline text links**, not tertiary buttons — they must be clearly readable as actions without a button shape.
- Use a **split button** (primary + dropdown caret) when an entity can be created in more than one way (e.g., import from template). Never use a dropdown-primary button for this.
- Use a **loading state** on the primary button after submit — do not disable the button without feedback.

---

## Form Fields

- Wrap every form control in `BdsFormItem` to get a consistently positioned label and validation message.
- Label alignment: `left` for horizontal forms, `top` for stacked/modal forms, `leftTop` when the input can grow tall. **Do not mix alignments within a single form.**
- Labels use **Distinct / SM** weight — heavier than body text so they read as labels.
- All text inputs use `BdsInput`. Never use a plain HTML input.
- All dropdowns use `BdsSelect`.
- For 2–5 single-choice options, use `BdsRadioGroup`. For 6+ options, use `BdsSelect`.
- For multiple-choice options, use `BdsCheckbox` / `BdsCheckboxGroup`. More than 5 options → use `BdsSelect` with multi-select.
- Checkbox labels must never wrap to a second line. If a label is long, rewrite it.
- Start each checkbox or radio label with a distinct word. If successive labels share the same opening verb, move it into the group legend.

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

## Purpose-driven States

Match the UI to the item's state: drafts open in edit mode, sent/published items open in view mode.

**Mode rules:**
- Drafts → edit mode. Never show view mode until the item has been sent or published.
- Sent/published items → view mode by default. Enter edit mode via the pencil icon.
- Elevate the key workflow action (Send, Publish) into create/edit mode — don't make users save first.

**Action limits:** Maximum 1 primary + 2 secondary actions visible at any time. Roll extras into overflow (⋯).

**Button order (right to left in toolbar):**
1. Primary action
2. Secondary workflow actions
3. Edit icon (pencil — no text label)
4. Copy / link icon
5. Overflow (⋯)

**Overflow order (top to bottom):**
1. Workflow actions (Recall, etc.)
2. Common actions (Print, Share)
3. Destructive actions (Delete, Void) — styled red, always last

**Hard rules:**
- Edit is always a pencil icon — never a text button labeled "Edit."
- Delete is always in overflow — never a standalone button.
- "Save and close" is never a label — "Save" implies close or transition.
- Cancel always requires a discard confirmation.

---

## List Page Header

Structure for any page displaying a list, table, or grid.

**Header lines (top to bottom):**
1. Title + breadcrumb + status badge (left) / action toolbar (right)
2. Page-level tabs (if applicable)
3. Data visualization — scrolls with content, does not stick
4. Grid controls: search bar, Expand/Collapse — sticky

If the page has both tabs and grid controls, place them on one line: tabs left, grid controls right.

**Action toolbar order (right to left):**
1. Primary action — one per page; use a split button if multiple creation methods exist
2. Secondary workflow actions — max 2
3. "Actions" dropdown (labeled, with caret) — when there are more than 2 workflow actions
4. Filter (tertiary icon) — always visible at all screen sizes, never collapses
5. Export, Settings, History, Help Center (tertiary icons, if applicable)

**Hard rules:**
- No ellipsis (⋯) overflow on desktop — use the labeled "Actions" dropdown instead.
- Batch actions go in the Floating Action Bar, not the header.
- The toolbar should have at least 2 icon buttons — add Help Center or Export if needed.

---

## Item Header

Structure for any item detail page (single entity: invoice, change order, to-do, etc.).

**Structure:**
- Action toolbar — top right
- Title + breadcrumb + status badge — left-aligned, line below the toolbar
- Tabs (if applicable) — line below the title

**Icon button order (left to right in toolbar):**
More (⋯) → Settings → Expand/Collapse → Activity → Share → Comments → Edit (pencil) → Back (←) → X

- Edit (pencil) and Comments always stay visible — never collapse them into overflow.
- Back (←) returns to previous screen. X closes a panel and returns to the view above — they are not interchangeable.

**Edit state:** Show 2–3 actions only.
- When Send is primary: Send (primary + icon) · Save (secondary) · Cancel (secondary)
- When Save is primary: Save (primary) · Cancel (secondary)
- When first creating (before first save): hide Comments, Activity, Share, Print, Delete.

**View state:** Max 1 primary + 2 secondary. Roll extras into overflow.

**Overflow always contains:** Print · Delete (red, last) · Recall · Void (red)

---

## Floating Action Bar

Appears when items are selected on a list page. Surfaces batch actions without displacing the page header.

**Three sections (separated by dividers):**
1. Selected count + X (deselect all)
2. Icon buttons: Edit (pencil) · Print · Copy · Delete (red, rightmost)
3. Workflow text buttons + overflow

**Workflow action limit:** Either 1 workflow action + "More actions" overflow, OR 2 workflow actions — never both.

**Send** always includes an icon on desktop. When rolled into overflow on mobile, no icon.

**Overflow labels:** "More actions" on desktop · "Actions" on mobile (≤767px).

**Mobile (≤767px):** Show only selected count + "Actions" overflow. All other controls roll into the overflow menu.

**Overflow order (desktop, top = closest to bar):**
1. Workflow actions
2. New / Add to existing actions
3. Common general actions
4. Recall actions
5. Destructive actions (Delete, Void — red, always last)

---

## Navigation

### Breadcrumbs (`BuiBreadcrumb`)

Show where the user is in the **site hierarchy** — not the path they took to get there.

- Standard depth: **Job Name > Feature area** (2–3 levels).
- The current page is always the **page title**, never a breadcrumb link.
- More than 3 levels: collapse middle items into an overflow menu — keep only the first and last visible.
- Disable breadcrumbs during save or submit operations to prevent navigation away from unsaved changes. Re-enable once the operation completes.

**Hard rule:** Never use workflow-based breadcrumbs. If a user arrives at an invoice via a change order, the invoice breadcrumb shows its own hierarchy (Job > Invoices) — not the path (Job > Change Orders > Invoice).

---

### Tabs (`BuiTabs`)

Use tabs to switch between different **views of the same data or subject matter** on a single page.

- If any tab has an icon, **all** tabs must have icons. Never mix tabs with and without icons.
- On mobile, the tab bar scrolls horizontally when tabs overflow — keep tab labels concise.

**Use tabs for:**
- Saved or filtered views of the same data table.
- Different representations of the same content (e.g., internal view vs. client-facing view).

**Do not use tabs for:**
- Mode or input method selection (flat fee vs. line items, choose date vs. link to schedule) → use a **segmented control**.
- Switching between distinct product features → use separate pages and navigation.
- Sub-navigation inside a tab panel → never stack tabs inside tabs.

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
