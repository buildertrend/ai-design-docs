# Layout foundations

## Intent
Provide a consistent, responsive page structure across all BTNet pages — from the global shell down to section-level spacing — so that layouts feel predictable and adapt cleanly across breakpoints.

> **Replaces BDSLayout.** These guidelines supersede the previous `BdsLayout`, `BdsRow`, `BdsCol`, `BdsSection`, and `BdsPanel` components. Use Tailwind utility classes for all page layout.

## Use when
Designing or building any page in BTNet.

---

## Page shell

All main content lives inside a shell with four fixed regions:

| Region | Value |
|---|---|
| Top Navigation | 48px height, fixed position |
| Job Panel | 240px default, 48px collapsed, resizable by dragging |
| Main Content | Fills remaining width |
| Side Panel | 400px default, resizable, can extend to full page |

The job panel and side panel are both resizable by the user. The side panel can be opened/closed by user action.

---

## Main content

The main content region has three sub-regions:

| Region | What goes here |
|---|---|
| Header | Page title, primary actions, status, breadcrumbs |
| Content | Forms, tables, lists — the main work area |
| Side Panel | Comments, activity, item details — supplemental info not part of the core object |

**Side panel content varies by page type:**
- **List pages:** Item details (condensed view of selected item), feature activity (e.g., schedule history)
- **Item pages:** Comments, activity log, version history

**Side panel specs:** 400px default width, resizable, full screen on mobile, opens via user action, overlays below 768px.

---

## Breakpoints

Every layout is built inside a content area with consistent responsive padding. Layout within the content area uses Tailwind utility classes. Use Tailwind width utilities on individual elements when you need to constrain them for readability.

| Breakpoint | Range | Padding | Token |
|---|---|---|---|
| Desktop | ≥ 992px | 32px | `bt:p-8` |
| Tablet | 768px – 991px | 24px | `bt:p-6` |
| Mobile | < 768px | 16px | `bt:p-4` |

**No max-width.** Pages and content areas stretch to fill the full available width within the viewport. This is a deliberate departure from older patterns that applied a max-width to pages.

---

## Spacing

Group related content in **sections**. Sections can be stacked (default) or side-by-side. Consider using a divider between side-by-side sections to visually separate their content.

Spacing tightens at smaller breakpoints to preserve usable content area.

| Breakpoint | Padding | Vertical gap | Horizontal gap |
|---|---|---|---|
| Desktop (≥ 992px) | 32px · `bt:p-8` | 32px · `bt:gap-y-8` | 24px · `bt:gap-x-6` |
| Tablet (768px – 991px) | 24px · `bt:p-6` | 24px · `bt:gap-y-6` | 24px · `bt:gap-x-6` |
| Mobile (< 768px) | 16px · `bt:p-4` | 16px · `bt:gap-4` | n/a — sections stack |

**Best practices:**
- Side-by-side sections stack on mobile (below 768px).
- Watch for dead space. Placing fixed-height content (a few form fields) next to dynamic content (rich text editor, attachment list) can create large empty areas. Consider stacking when content heights will diverge significantly.

---

## Composition patterns

Sections can be arranged in many ways. These are common starting points — not rigid templates.

| Pattern | Description |
|---|---|
| Stacked | Full-width sections stacked vertically. Simplest starting point. |
| Narrow + Wide | 1/3 and 2/3 width split. Left side for metadata or a summary, right side for the main content. |
| Equal Split | 50/50 width split. Use when both sections are of equal importance. |
| Stacked + Split | Full-width section above a 1/3 + 2/3 pair. Useful for a summary above a detail split. |
| Multi-row | Mix of full-width rows and multi-column rows. For complex pages with clearly distinct content groups. |

**Tips:**
- Stacked is the simplest starting point. Only split when it helps the content.
- Side-by-side sections stack on mobile, so make sure each half works on its own at narrow widths.
- These patterns can be combined in any way that fits the content.

---

## Code templates

**Basic responsive page — stacked sections:**

```tsx
<div className="bt:p-4 bt:md:p-6 bt:lg:p-8">
    <div className="bt:flex bt:flex-col bt:gap-4 bt:md:gap-y-6 bt:lg:gap-y-8">
        {/* Each child is a full-width section */}
        <div>{/* Section 1 */}</div>
        <div>{/* Section 2 */}</div>
    </div>
</div>
```

**Side-by-side sections with divider — stacks on mobile:**

```tsx
<div className="bt:p-4 bt:md:p-6 bt:lg:p-8">
    <div className="bt:flex bt:flex-col bt:gap-4 bt:md:gap-y-6 bt:lg:gap-y-8">
        {/* Side-by-side on tablet+, stacked on mobile */}
        <div className="bt:flex bt:flex-col bt:md:flex-row bt:gap-x-6">
            <div className="bt:w-full bt:md:w-1/3">{/* Narrow section */}</div>
            <div className="bt:hidden bt:md:block bt:w-px bt:bg-gray-20 bt:self-stretch" />
            <div className="bt:w-full bt:md:w-2/3">{/* Wide section */}</div>
        </div>

        {/* Full-width section */}
        <div>{/* Section content */}</div>
    </div>
</div>
```

---

## Anti-patterns

- Applying a max-width to a page or content area — all content fills available width.
- Using a fixed horizontal gap between sections on mobile — sections stack with vertical gap only.
- Placing fixed-height content side-by-side with dynamic-height content when heights will diverge significantly — stack instead.
- Nesting responsive padding — apply padding only at the top-level content wrapper, not inside each section.
