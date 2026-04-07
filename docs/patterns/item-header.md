# Item header

## Intent
Provide a consistent, predictable header structure for item detail pages that surfaces the right actions for the current mode (create, edit, or view) and adapts across screen sizes.

## Use when
Designing any item detail page — a page showing the detail of a single entity (e.g. a change order, invoice, to-do, daily log).

## Avoid when
Designing list pages — use the list page header pattern instead.

---

## Header structure

The item header has two main parts:

1. **Action toolbar** — top right. Contains primary, secondary, and icon buttons.
2. **Title, breadcrumb, and status badge** — left-aligned, on the line below the toolbar.

If the item has tabs, tabs sit on the line below the title and status.

---

## Action toolbar rules

- Maximum **1 primary action** and **2 secondary workflow actions** at any time.
- Icon buttons follow a fixed order (see below).
- The "More" overflow (⋯) is always the leftmost icon button, before Back (←) and Close (✕).
- Always surface the Edit (pencil) and Comments icon buttons — they should not collapse into overflow.

### Icon button order (left to right in toolbar)
1. More / overflow (⋯)
2. Settings
3. Expand / Collapse
4. Activity log
5. Share
6. Comments
7. Edit (pencil)
8. Back arrow (←) — full-screen pages and mobile
9. X — panels only (closes and returns to the view above)

---

## Edit state

Edit states should feature 2–3 action buttons:

**When Send is the primary action:**
- Send (primary, with icon)
- Save (secondary)
- Cancel (secondary)

**When Save is the primary action:**
- Save (primary)
- Cancel (secondary)

**When first creating an item (before the first Save)**, do not show:
- Comments
- Activity log
- Share
- Print
- Delete

These become available once the item has been saved for the first time.

---

## View state

- Maximum 1 primary and 2 secondary actions visible.
- If there are more than 3 workflow actions, roll extras into the overflow menu (⋯).
- Always show the Edit (pencil) icon button if the item is still editable.
- Delete and Print always live in the overflow menu — never as standalone buttons.

---

## Title, breadcrumb, and status

- In view mode, the title field is read-only and acts as the page heading.
- The status badge and metadata sit inline with the title in view mode.
- If the item doesn't have a title field, substitute: item type, item metadata, or file name.

---

## Primary button guidance

**Save:**
- Always closes the item or transitions to view mode after saving.
- Do not include "Save and close" — "Save" implies close or transition.

**Send:**
- Always accompanied by an icon to visually differentiate it from Save.
- Returns user to previous context after sending.

---

## Secondary button guidance

**Resend:**
- Style as secondary, or place in overflow. Never primary.

**Dropdown menus (Add to, Download, New):**
- Use for actions like attaching to other items, downloading in multiple formats, or creating related items.
- Label with "Add to," "Download," or "New." Do not use "Create."

---

## Overflow menu contents

- Print — always in overflow.
- Delete — always in overflow, styled red70, always the last item.
- Recall — in overflow, styled normally.
- Void — in overflow, styled red70.

---

## Responsiveness

The item header is designed to be consistent across desktop and mobile web. On mobile, the layout stacks appropriately and the Back arrow (←) is used instead of breadcrumb navigation.

---

## Accessibility

- Edit (pencil) and Comments icon buttons must always be reachable — don't collapse them.
- All icon-only buttons need an `aria-label`.
- The X and Back arrow have distinct meanings and must be implemented correctly:
  - Back arrow (←): returns to the previous screen.
  - X: closes the panel and returns to the view above in the information architecture.

---

## Anti-patterns

- More than 1 primary and 2 secondary actions visible at once — roll extras into overflow.
- A text "Edit" button — use the pencil icon only.
- Delete or Print as standalone buttons — always in the overflow menu.
- "Save and close" as a button label — "Save" is assumed to close or transition.
- "Resend" styled as primary — it's always secondary.
- Missing Cancel in any edit state that has Save.
