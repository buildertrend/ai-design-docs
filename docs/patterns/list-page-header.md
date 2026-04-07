# List page header

## Intent
Provide a consistent, scannable header structure for all list pages (tables, grids, item lists) that makes primary actions discoverable and adapts predictably across screen sizes.

## Use when
Designing any page that displays a list, table, or grid of items.

## Avoid when
Designing item detail pages — use the item header pattern instead.

---

## Header elements

A list page header has up to 5 elements, each on its own line:

1. **Title, breadcrumbs, and status badge** (left) + **action toolbar** (right)
2. **Page-level tabs** (if applicable)
3. **Data visualization** (if applicable)
4. **Grid controls** — search bar, Expand/Collapse (if applicable)

**Exception:** If the page has both tabs and grid controls, place them on a single line. Tabs left-aligned, grid controls right-aligned.

---

## Action toolbar hierarchy (right to left)

| Position | Element | Notes |
|---|---|---|
| 1st (rightmost) | Primary action button | One per page. Use a split button if the entity can also be imported or created from a template. |
| 2nd | Secondary workflow action | Max 2 secondary buttons total in the header. |
| 3rd | "Actions" overflow menu | Use when there are more than 2 workflow actions. Label: "Actions" + caret icon. |
| Then | Filter | Tertiary icon button. Always visible — never collapses. |
| Then | Export | Tertiary icon button (if applicable). |
| Then | Settings | Tertiary icon button (if applicable). |
| Then | History / Activity log | Tertiary icon button (if applicable). |
| Then | Help Center | Tertiary icon button (if applicable). |
| Then | Overflow | Tertiary icon button, small screens only. |

**Minimum:** The toolbar should have at least 2 icon buttons. Fewer makes it harder to parse and less discoverable. If needed, add Help Center or Export first.

**No ellipsis (⋯) on desktop.** All overflow on desktop uses the "Actions" dropdown label, not an icon-only ellipsis.

---

## Primary split button

Use a split button (not a dropdown primary button) when the entity can be created in more than one way (e.g., import from template). The split button allows one-click creation for the primary method while exposing alternatives in the dropdown.

---

## Scroll behavior

**Sticky (do not scroll):**
- Title, breadcrumbs, badge
- Action toolbar
- Tabs
- Grid controls (search bar, Expand/Collapse)

**Scrolls with content:**
- Data visualization

---

## Responsiveness

The header max-width is 1500px. Below 768px, responsive breakpoints apply:

| Breakpoint | Behavior |
|---|---|
| ~498px | Primary split button collapses to icon-only split button |
| ~427px | Farthest two icon buttons collapse into the overflow menu |
| ~381px | More icons roll into overflow; Filter always stays visible |
| ~326px | Breadcrumb truncates to prevent encroaching on the toolbar |

The Filter button always remains visible at all screen sizes.

---

## Batch actions

Batch actions are surfaced in the Floating Action Bar — not the list page header. This keeps the header accessible and visible while batch actions are active. See the floating action bar pattern.

---

## Accessibility

- The primary button must always be reachable via keyboard.
- Icon-only buttons must have descriptive `aria-label` values.
- The Filter button must remain visible and operable at all screen sizes.

---

## Anti-patterns

- More than 2 secondary buttons in the header — roll extras into "Actions."
- Using a dropdown primary button instead of a split button when multiple creation methods exist.
- Putting batch actions in the header — use the Floating Action Bar instead.
- An ellipsis (⋯) icon overflow on desktop — use "Actions" label instead.
- Data visualization that doesn't scroll with the content — it should scroll, not stick.
