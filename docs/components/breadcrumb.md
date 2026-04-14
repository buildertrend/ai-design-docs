# BuiBreadcrumb

## Intent
Show the user where they are in the site hierarchy. Breadcrumbs orient users within the application structure and provide a way to navigate to parent pages.

## Use when
Designing any page with a parent–child hierarchy — typically all non-top-level pages.

## Avoid when
- The page is a top-level navigation destination with no parent.
- The user is in a modal or panel — breadcrumbs are for full pages only.

---

## Structure

Use `BuiBreadcrumb` as the container and `BuiBreadcrumb.Item` for each level. The component automatically adds separators between items.

```tsx
<nav aria-label="Breadcrumb">
  <BuiBreadcrumb testid="job-breadcrumb">
    <BuiBreadcrumb.Item testid="job">
      <BdsLink to="/jobs/123">Maple Street Remodel</BdsLink>
    </BuiBreadcrumb.Item>
    <BuiBreadcrumb.Item testid="feature">
      <BdsLink to="/jobs/123/invoices">Invoices</BdsLink>
    </BuiBreadcrumb.Item>
  </BuiBreadcrumb>
</nav>
```

The current page is shown as the **page title**, not as a breadcrumb item.

---

## Hierarchy rules

- Breadcrumbs reflect the **page's location in the site structure** — not the path the user took to get there.
- Most pages follow a 2–3 level hierarchy: **Job Name > Feature area**.
- If a user navigates from a change order to a related invoice, the invoice breadcrumb shows its own hierarchy (Job > Invoices), not the workflow trail (Job > Change Orders > Invoice).

**Deep navigation (more than 3 levels):** Collapse middle items into an overflow menu, keeping only the first and last items visible. Use `BuiMenu` as the overflow content.

---

## States

| State | When to use |
|---|---|
| Default | All items interactive. |
| Disabled | During save or submit operations — prevents users from navigating away with unsaved changes. Restore to interactive once the operation completes. |

Only disable breadcrumbs during transient operations. They should be interactive in all other states.

---

## Mobile behavior

On narrow viewports, breadcrumb links wrap to the next line and long text truncates with an ellipsis. This keeps the breadcrumb compact even with long job or page names.

---

## Requirements

- Always wrap `BuiBreadcrumb` in a `<nav aria-label="Breadcrumb">` element.
- Use `BdsLink` (or `<a>`) for all breadcrumb items that are navigable.
- The current page must not appear as a breadcrumb item — display it as the page title.

---

## Accessibility

- The `<nav aria-label="Breadcrumb">` wrapper provides a navigation landmark for screen readers.
- Add `aria-current="page"` to the current page element if it appears in the breadcrumb (though the preferred pattern is to omit it and use the page title instead).
- Keyboard: `Tab` / `Shift+Tab` move between links; `Enter` activates the focused link.

---

## Anti-patterns

- Using workflow-based breadcrumbs (showing how the user got here rather than where they are).
- Including the current page as a breadcrumb link — it should be the page title, not a link.
- Omitting the `<nav aria-label="Breadcrumb">` wrapper — screen readers cannot identify the region.
- Showing breadcrumbs inside a modal or panel.
