# Empty states

## Intent
Help users understand why a space is empty, orient them in the product, and guide them toward a clear next action. Empty states support feature adoption and build trust through consistent, helpful messaging.

## Use when
Any list, grid, or content area has no data to display — whether because nothing has been created yet, a filter returned no results, a system error occurred, or the user lacks permissions.

## Avoid when
The content area is loading — show a loading state, not an empty state.

---

## Requirements

### Structure (onboarding empty states)
Every feature onboarding empty state must include:
1. The feature icon
2. A short header
3. 1–2 lines of explainer text

### Header copy
Header text should read: **"Add [a] [name of item]"**

Examples:
- "Add a daily log"
- "Add a change order"
- "Add a to-do"

### Body copy
- Give a brief explanation of the item or feature in the first sentence.
- Educate the user — don't upsell or market the feature.
- 1–2 sentences maximum.

### Button placement
Do not include a primary action button in the empty state if one already exists in the page header. The header button is sufficient.

---

## The 6 empty state types

| Type | When to use | Icon |
|---|---|---|
| **Onboarding** | No items have been created yet (e.g., no change orders, no integrations set up) | Feature icon |
| **Structural** | Required data hasn't been added elsewhere for this area to populate (e.g., no data to generate a report) | Feature icon |
| **Temporary** | Content is temporarily absent (e.g., all tasks complete, all jobs closed and filtered out) | Feature icon |
| **Permissions** | The user lacks access to view this data | Warning / exclamation icon |
| **Error** | A system failure occurred (e.g., lost connection, page error) | Warning / exclamation icon |
| **Search / filter** | A search or filter returned no matching results | Feature icon or search icon |

### Permissions and error states

These two types differ from onboarding empty states in content requirements:
- Use a **warning or exclamation icon** — not the feature icon.
- Messaging must be **actionable**: explain what went wrong or why access is restricted, and tell the user what they can do next.
- Do not leave the user with no path forward — always provide a next step (e.g., contact an admin, try again, check connection).

---

## Recommendations

- Center-align the empty state content within the content area.
- Use the feature's icon, not a generic placeholder icon.
- Keep the explainer text factual and helpful — not promotional.
- Use the `EmptyState` component — it handles responsive layout (mobile, tablet, desktop) automatically.

---

## Accessibility

- The feature icon should have appropriate alt text or be marked as decorative if the heading already conveys the meaning.
- Ensure the empty state is announced correctly by screen readers — it should not be hidden or skipped.

---

## Examples

**Do:**
> Icon: Daily Log icon
> Header: "Add a daily log"
> Body: "Daily logs help you document project progress and share updates with clients."
> *(No primary button — one already exists in the page header)*

**Do:**
> Icon: Task icon
> Header: "Add a to-do"
> Body: "Assign tasks to team members to keep projects on track."

---

## Anti-patterns

- Including a primary button in the empty state when one already exists in the header — creates confusion about where to act.
- Using a generic "No data" message without context or next steps.
- Writing promotional copy ("Unlock the power of daily logs!") — empty states orient, they don't upsell.
- Using placeholder or generic icons instead of the feature's actual icon.
- Headers that don't follow the "Add [a] [item]" pattern for onboarding states.
