# BTSplitView

## Intent
Provide a responsive list/detail split-view layout where selecting an item from a list shows its details alongside (or instead of) the list. Wraps `BuiSplitView` with mode switching, responsive collapse, and analytics.

## Use when
- A list page needs to show item details without navigating away.
- Users need to compare or reference the list while viewing a detail.

## Avoid when
- The detail content is a standalone page with no associated list context.
- A modal or drawer is sufficient for the detail content.

## Requirements
- `mode` (required) — controls which panels are visible: `"list"`, `"split"`, or `"detail"`.
- `list` (required) — the list panel content.
- `detail` (required) — the detail panel content.
- `testid` (required) — test identifier for the component.
- `name` (required) — identifies the split view for analytics.

## Recommendations
- Default to `mode="list"` on initial load. Switch to `"split"` when the user selects an item, and to `"detail"` when navigating fully into an item.
- Use `defaultDetailWidth` (pixels) to set the initial detail panel width. Default is inferred from `BuiSplitView`.
- Use `minDetailWidth` (pixels) to prevent the detail panel from becoming too narrow to use.
- Use `maxDetailSize` (percentage, 0–100) to cap how wide the detail panel can grow.
- Size units: `defaultDetailWidth` and `minDetailWidth` are in **pixels** (converted to percentage internally); `maxDetailSize` is a **percentage**.

## Platform notes
- Below 768px, `"split"` mode automatically collapses to show only the detail panel. Design both panels to work independently at narrow widths.
- On mobile, users cannot see the list and detail simultaneously — ensure navigation back to the list is always available from the detail panel.

## Accessibility
- The draggable resize handle must be keyboard-operable.
- When mode switches programmatically (e.g., selecting an item), focus should move into the detail panel.
- Ensure the list panel retains its scroll position when the user returns to it.

## Examples

```tsx
{/* Basic split view */}
<BTSplitView
    mode="split"
    testid="invoices-split"
    name="Invoices"
    list={<InvoiceList onSelect={handleSelect} />}
    detail={<InvoiceDetail invoiceId={selectedId} />}
/>
```

```tsx
{/* Mode-controlled by parent */}
const [mode, setMode] = useState<BTSplitViewMode>("list");

<BTSplitView
    mode={mode}
    testid="bills-split"
    name="Bills"
    list={<BillList onSelect={() => setMode("split")} />}
    detail={<BillDetail onBack={() => setMode("list")} />}
/>
```

```tsx
{/* Custom sizing */}
<BTSplitView
    mode="split"
    testid="schedule-split"
    name="Schedule"
    list={<ScheduleList />}
    detail={<ScheduleDetail />}
    defaultDetailWidth={500}
    minDetailWidth={300}
    maxDetailSize={60}
/>
```

### Modes

| Mode | Behavior |
|---|---|
| `"list"` | List takes full width, detail is hidden |
| `"split"` | Both panels visible with a draggable handle |
| `"detail"` | Detail takes full width, list is hidden |

## Anti-patterns

- Passing `defaultDetailWidth` or `minDetailWidth` as percentages — these props expect pixel values.
- Leaving `mode` static — it should respond to user interactions (selecting an item, navigating back).
- Placing `BTSplitView` inside a fixed-height container that prevents the panels from filling the viewport.
