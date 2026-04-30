# BdsBadge

## Intent
Communicate the status, a property, or other metadata related to a larger interface component. Each badge combines a color and icon from the feedback system to consistently indicate the state of an associated object.

## Use when
- Showing the status of an item (e.g., Active, Pending, Overdue).
- Labeling a property or category alongside a list item, table cell, or card.
- The associated object already provides context — the badge supplements it.

## Avoid when
- The interface needs an interactive element — badges are non-interactive labels.
- Communicating information that belongs in body copy rather than a status label.

## Requirements
- Always pair color with an icon or text — never rely on color alone to convey meaning.
- Icon-only badges must be used alongside a visible label elsewhere on the page, or provide a tooltip for the icon.
- Use `displayType` to set the color/icon combination — do not apply custom colors.

## Recommendations
- Prefer `text-only` badges when a status label is needed and the icon adds no clarity.
- Use icon-only mode (`icon` or `displayType` prop, no text) only when screen real estate is very tight and the icon's meaning is well-established in context.
- Use `textOnly={true}` when an icon is unnecessary.

## Platform notes
- Icon-only badges can roll up on narrow screen sizes; text-only badges do not.

## Accessibility
- Color is never the sole differentiator — every `displayType` includes an icon paired with the color signal.
- Do not remove the icon from a status badge if it is the only non-color indicator.

## Examples

```tsx
{/* Status badge with icon + text */}
<BdsBadge displayType="success" text="Active" />

{/* Text-only badge */}
<BdsBadge text="Draft" textOnly />

{/* Icon-only badge (rolls up at narrow widths) */}
<BdsBadge displayType="warning" />
```

### Status display types

| `displayType` | Semantic meaning |
|---|---|
| `success` | Completed, approved, active |
| `warning` | Needs attention, at-risk |
| `danger` | Error, overdue, critical |
| `info` | Informational, in-progress |
| `default` | Neutral, no status signal |

## Anti-patterns

- Applying a badge to indicate an action — use a button instead.
- Using custom colors outside the `displayType` system.
- Placing two status badges on the same item without a clear distinction between what each represents.
