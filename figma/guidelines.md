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

### Page shell

Every page lives in a shell with four regions:

| Region | Value |
|---|---|
| Top Navigation | 48px height, fixed |
| Job Panel | 240px default · 48px collapsed · resizable |
| Main Content | Fills remaining width |
| Side Panel | 400px default · resizable · can extend full page |

### Main content regions

| Region | What goes here |
|---|---|
| Header | Page title, primary actions, status, breadcrumbs |
| Content | Forms, tables, lists — main work area |
| Side Panel | Comments, activity, item details — supplemental, not core |

Side panel: 400px default, resizable, overlays below 768px.
- **List pages:** item details or feature activity in the side panel
- **Item pages:** comments, activity log, version history in the side panel

### Breakpoints and padding

No max-width on pages or content areas — everything fills available width.

| Breakpoint | Padding |
|---|---|
| Desktop (≥ 992px) | 32px |
| Tablet (768px – 991px) | 24px |
| Mobile (< 768px) | 16px |

### Section spacing

Group related content in sections. Default to stacking. Use side-by-side only when it helps the content.

| Breakpoint | Vertical gap | Horizontal gap |
|---|---|---|
| Desktop | 32px | 24px |
| Tablet | 24px | 24px |
| Mobile | 16px | n/a — sections stack |

Use a divider between side-by-side sections. Side-by-side sections always stack on mobile. Avoid placing fixed-height content beside dynamic-height content when heights will diverge — stack instead.

---

## Status & Labels

- Use `BdsBadge` for status labels (success, warning, danger, info). Never use a plain `<span>` or custom chip.
- Use `BdsPill` for compact, removable, or selectable tags.
- **Never rely on color alone** to communicate status. Every badge must pair color with an icon, text, or both.

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
3. "Actions" **secondary dropdown button** (labeled, with downward-facing caret) — when there are more than 2 workflow actions
4. Filter (tertiary icon) — always visible at all screen sizes, never collapses
5. Export, Settings, History, Help Center (tertiary icons, if applicable)

**Hard rules:**
- No ellipsis (⋯) overflow on desktop — use the labeled "Actions" dropdown instead.
- Batch actions go in the Floating Action Bar, not the header.
- The toolbar should have at least 2 icon buttons — add Help Center or Export if needed.
- Card-view grids may include a standalone "Select all" control on its own line below the grid controls. Do not merge it with tabs or other controls.
- Data visualization scrolls with the table content. On mobile, truncate it to the single most important value — determined by the feature team.

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

## Menus

Use `BuiMenu` for all dropdown menus (contextual, overflow, action menus).

**Item ordering (top to bottom):**
1. Workflow actions (primary tasks — Send, Approve, Recall)
2. Common actions (Print, Share, Copy, Export)
3. Destructive actions — always last, always styled red (Delete, Void, Disconnect)

**Hard rules:**
- Destructive items are always at the bottom and always red.
- Never place a destructive action in the middle of a menu.

---

## Split View

Use `BTSplitView` for list/detail layouts where selecting an item shows details alongside the list.

**Three modes:**
- `list` — full-width list, detail hidden
- `split` — both panels visible with a draggable divider
- `detail` — full-width detail, list hidden

**Responsive:** Below 768px, split mode collapses to detail-only. Design both panels to be independently usable at narrow widths. Always provide a way to navigate back to the list from the detail panel on mobile.

---

## Activity Log

Activity logs appear in the **side panel**, opened via the history icon in the item header. They are available on item pages only — not list pages.

**Entry anatomy:** Icon · Action description · by [Actor] · on [Date], [Time]

**Expandable details:** Include a "Show changes" / "Show details" toggle on entries where the action saved changes. Keep the top-level description concise — field-level details go inside the expanded section.

**Change formatting (inside expandable section):**
- Field label — plain text
- Old value — struck through, red
- Separator — →
- New value — standard text

**Standard action icons:**

| Action | Icon |
|---|---|
| Created / Added | PlusCircle |
| Updated | NotePencil |
| Deleted | XCircle |
| Approved / Success | CheckCircle |
| Sent | PaperPlaneRight |
| Ready for payment | ArrowCircleRight |
| Paid / Payment recorded | CurrencyCircleDollar |

**Hard rules:**
- Always show actor name and timestamp — never omit either.
- Use past-tense verbs only: "Updated," "Created," "Deleted," "Approved."
- Never show the activity log inline in the page body.

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
