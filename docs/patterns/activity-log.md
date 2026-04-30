# Activity Log

## Intent
Show users a chronological history of actions taken on an item — who did what, when, and what changed. Gives users confidence that the record is accurate and provides an audit trail without cluttering the main editing surface.

## Use when
- An entity (bill, selection, schedule item, etc.) has meaningful state changes users need to trace.
- Users need to understand what was changed, by whom, and when.
- The feature area supports the Entity Change Tracking system.

## Avoid when
- The entity has no meaningful change history (e.g., purely transient data).
- A simple "last modified by" timestamp is sufficient.

## Requirements
- The activity log appears in a **side panel**, opened via the activity log icon in the item header.
- Every log entry must follow the anatomy: **Icon** + **Action description** + **by [Actor]** + **on [Date], [Time]**
- Entry descriptions must use past-tense action verbs: "Updated," "Created," "Deleted," "Approved," "Sent."
- Always include the actor name and timestamp — never omit either.
- Use the standard icon set (see Action Types below) — do not substitute arbitrary icons.

## Recommendations
- Include **expandable details** ("Show changes" / "Show details") on entries where changes were saved. Keep the top-level description concise; move field-level details into the expandable section.
- Keep descriptions concise at the top level — details belong in the expandable section.

## Platform notes
- The activity log panel is accessed from the item header icon on all platforms.
- On mobile, the panel opens as a full-screen overlay.

## Accessibility
- The activity log icon in the header must have an `aria-label` (e.g., "View activity log").
- Expandable "Show changes" sections must be keyboard-operable and announce their state to screen readers (`aria-expanded`).
- Timestamps should use a human-readable format, not raw ISO strings.

## Examples

### Entry anatomy

```
[Icon]  Updated by Jane Smith on Mar 15, 2026, 2:34 PM
        ▼ Show changes
           Status:    ~~Draft~~ → Submitted
           Amount:    ~~$4,500.00~~ → $5,200.00
           Due Date:  ~~03/01/2026~~ → 03/15/2026
```

### Formatting changes

When displaying field-level changes inside an expandable section:

| Element | Style |
|---|---|
| Field label | Plain text |
| Old value | Struck through, red text |
| Separator | → |
| New value | Standard (or bold) text |

For deleted line items, show all deleted values using the same struck-through red treatment so users can reference what was removed.

### Action types and icons

| Action | Icon |
|---|---|
| Created | `PlusCircle` (blue) |
| Added (line item, etc.) | `PlusCircle` (blue) |
| Updated | `NotePencil` (blue) |
| Deleted | `XCircle` (blue) |
| Approved | `CheckCircle` (blue) |
| Ready for payment | `ArrowCircleRight` (blue) |
| Sent | `PaperPlaneRight` (blue) |
| Paid | `CurrencyCircleDollar` (blue) |
| Payment recorded | `CurrencyCircleDollar` (blue) |

Additional action types can be added as features require. The icon set above is the current standard — coordinate with the design system team before adding new icons.

### Frontend usage

```tsx
<ActivityLog
    entityId={selectionId}
    externalEntityId={externalSelectionId}
    externalBuilderId={externalBuilderId}
    externalJobId={externalJobId}
    entityType={EntityTypes.Selection}
    createdDateTime={selection.createdDate}
    createdBy={selection.createdByName}
    entityTrackingDate={ENTITY_TRACKING_START_DATE}
    onClose={handleClose}
/>
```

`entityTrackingDate` is the date tracking was enabled for this entity type. The component shows a warning if the entity predates tracking, setting the right expectation that older history is not available.

## Anti-patterns

- Omitting actor name or timestamp from an entry.
- Putting field-level change details in the top-level description — those belong in the expandable section.
- Using present-tense verbs ("Updates," "Creates") — use past tense.
- Showing the activity log inline in the page body — it belongs in the side panel, accessed via the header icon.
- Using a custom icon not in the standard action-type set without coordinating with the design system team.
