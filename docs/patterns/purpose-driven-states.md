# Purpose-driven states

## Intent
Match the interface to the user's context by separating view mode (understanding information) from edit mode (making changes). This reduces accidental edits, surfaces the next logical action, and makes shared assets clearer for collaborators.

## Use when
Designing workflows where a user creates an asset that will later be reviewed, approved, paid, or acted on by others — or where an item transitions from draft to a shared/published state.

## Avoid when
The workflow is purely for internal data entry with no review, sharing, or approval step (e.g., simple reference data). In those cases, always-on edit mode is appropriate.

---

## Determining which workflow type applies

| Question | Workflow type |
|---|---|
| Will the item be approved, paid, reviewed, or completed later? | Process-oriented |
| Is the main purpose to sync to an accounting integration (e.g. QuickBooks)? | Accounting only |
| Is the main purpose rapid bulk data entry (many items at once)? | Bulk entry |
| Can an admin create and immediately approve/complete in one step? | Admin only |
| Is this a settings page broken into sections? | Modular settings |

---

## Workflow types

### Process-oriented workflows
For items that move forward through a larger process (e.g. sent, approved, completed).

- **Drafts always open in edit mode.** Don't show view mode until the item has been sent or published.
- **Elevate the key workflow action** (Send, Publish) into create/edit mode so users can complete the process without saving first.
- After the item is sent/published, open subsequent visits in **view mode**.

**Examples:** Daily Logs, To-dos, Change Orders, Invoices (with clients)

**Create mode actions:**
| Action | Behavior |
|---|---|
| Publish / Send | Creates and shares the item. Returns to previous context. |
| Save | Creates the item. Returns to previous context. |
| Save and new | Creates the item. Opens a new blank create mode. |
| Cancel | Discards progress. Returns to previous context. |

**View mode actions:**
| Action | Behavior |
|---|---|
| Edit (pencil icon) | Transitions to edit mode. |
| Mark complete / Approve | Changes status. Stays in view mode. |

**Edit mode actions:**
| Action | Behavior |
|---|---|
| Save | Saves changes. Returns to view mode. |
| Save and new | Saves changes. Opens new create mode. |
| Cancel | Discards changes. Returns to view mode. |

---

### Accounting-only workflows
A variation of process-oriented. The user isn't sending to clients — they're syncing to an accounting integration.

- Elevate "Send to QuickBooks" (or equivalent) into create/edit mode instead of "Send."
- After syncing, open in view mode. To resync, the user must enter edit mode.

---

### Bulk entry workflows
For rapid creation of many items at once (e.g. cost items in an estimate).

- No elevated workflow action in create/edit — just Save, Save and new, Cancel.
- Items remain in edit mode until their parent asset is locked or sent.
- Once the parent is sent, child items inherit view mode from the parent.

---

### Admin-only workflows
The admin can create and immediately finalize (approve, mark paid) in one step.

- Elevate the approval action (Approve, Mark paid) into create/edit mode alongside Save.
- After approval, open subsequent visits in view mode with the option to edit.

---

### Modular settings workflow
Large settings pages broken into focused, independently-editable sections.

- Default to view mode for each section — read-only, easy to scan.
- Each section has its own Edit button to enter section-level edit mode.
- Saving or cancelling a section returns to that section's read-only view.
- No page-wide edit mode — only section-level.

---

## Action button rules

### Core button behavior

| Button | Style | Behavior |
|---|---|---|
| Save | Primary | Returns to previous context (list or view mode) |
| Save and new | Secondary split | Saves and opens a blank create mode |
| Send | Primary + icon | Returns to previous context |
| Publish | Primary | Returns to previous context |
| Approve | Primary | Stays in place; updates status |
| Mark complete | Primary | Stays in place; updates status |
| Edit | Tertiary icon (pencil) | Transitions to edit mode. Icon only — no "Edit" text button. |
| Cancel | Secondary | Discards changes. Returns to previous context. Confirmation required. |
| Delete | Text, red70, overflow only | Available in view mode only. Always in overflow menu — never as a standalone button. |

### Button order (right to left)
1. Primary action
2. Secondary workflow actions
3. Edit icon (if applicable)
4. Copy / link icon (if applicable)
5. Overflow (⋯)

### Overflow menu order (top to bottom)
1. Workflow actions (Recall, Issue refund, etc.)
2. Common actions (Print, Share)
3. Destructive actions (Delete, Void) — styled red70, always last

---

## Interaction availability by mode

| Interaction | Create | Edit | View |
|---|---|---|---|
| Editing form fields | ✓ | ✓ | — |
| Adding line items | ✓ | ✓ | — |
| Adding attachments | ✓ | ✓ | ✓ |
| Viewing attachments | ✓ | ✓ | ✓ |
| Comments | — | ✓ | ✓ |
| Adding related items | — | ✓ | ✓ |
| Adding tags | ✓ | ✓ | ✓ |

---

## Accessibility

- Ensure edit and view mode transitions are announced to screen readers.
- Confirmation dialogs before Cancel (discard) must be keyboard accessible.
- Icon-only buttons (Edit pencil) must have an `aria-label`.

---

## Anti-patterns

- Opening a sent/published item in edit mode by default — it should open in view mode.
- Placing Delete as a standalone button — always in the overflow menu.
- Using an "Edit" text button — use the pencil icon only.
- Showing a view mode for a draft — drafts always open in edit mode.
- Including more than 1 primary and 2 secondary actions in the header at once.
