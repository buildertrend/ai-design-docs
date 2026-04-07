# Floating action bar

## Intent
Surface batch actions on list pages in a focused, discoverable bar that appears when items are selected — without displacing or obscuring the list page header.

## Use when
A list page supports selecting multiple items and taking actions on them at once (batch actions).

## Avoid when
There are no multi-select or batch action needs on the page. Single-item actions belong in the item header or row-level controls.

---

## Structure

The floating action bar (FAB) has three sections separated by dividers:

1. **Selected count** — shows how many items are selected, with an X to deselect all.
2. **Icon button section** — common actions: Edit (batch edit), Print, Copy, Delete.
3. **Text button section** — workflow actions and overflow menu.

**Maximum workflow actions on desktop:** 1 workflow action + 1 "More actions" overflow, OR 2 workflow actions. Never 2 workflow actions plus an overflow.

---

## Icon button section

| Button | Notes |
|---|---|
| Edit (pencil) | Triggers batch edit mode for selected items |
| Print | Batch print |
| Copy | Batch copy |
| Delete | Styled red70 — destructive, placed rightmost in the icon section |

---

## Workflow action buttons

**Send:**
- Styled as text + icon button.
- The only workflow action that includes an icon on the FAB.
- When rolled into the overflow menu (small screens), no icon is used.

**New (item creation):**
- Styled as an overflow menu with text + upward-facing caret.
- Used when the primary batch workflow is creating new related entities.

---

## Overflow menu ("More actions")

### Desktop order (top = closest to FAB)
1. Workflow actions (in order of expected process — decided by feature team/SME)
2. "New" or "Add to existing" actions (grouped by item type; "New" above "Add to existing")
3. Common general actions (Print variants, Attach files, Add documents, Edit settings, Show to subs)
4. Recall actions (not destructive — styled normally)
5. Destructive actions (Delete, Void) — styled red70, always last

### Mobile order (screens ≤767px, label: "Actions")
1. Send and Recall (grouped together, closest to FAB)
2. Other workflow actions (in order of expected process)
3. "New" or "Add to existing" actions (grouped by item type)
4. Common general actions (including icon buttons that collapsed at small size)
5. Destructive actions (Delete, Void) — styled red70, furthest from FAB. Void below Delete.

Groups are separated by dividers.

---

## Responsiveness

| Screen size | FAB behavior |
|---|---|
| ≥768px (desktop) | Shows selected count, icon buttons, and text workflow buttons. Overflow labeled "More actions" + caret. |
| ≤767px (mobile) | Shows only selected count and "Actions" overflow menu. All actions roll into overflow. |

---

## Accessibility

- The FAB must not cover the primary page action button or key content when active.
- The X (deselect all) button must be keyboard accessible.
- Destructive actions (Delete, Void) styled in red70 must also be distinguishable without color — use placement (last in menu) and clear labeling.
- All icon-only buttons need `aria-label` values.

---

## Anti-patterns

- Placing batch actions in the list page header — they belong in the FAB.
- Surfacing 2 workflow actions AND an overflow menu — choose one or the other.
- Styling Delete or Void in the same way as non-destructive actions — always use red70.
- Including "Send" without its accompanying icon on desktop.
- Labeling the overflow "More actions" on mobile — use "Actions" on small screens.
