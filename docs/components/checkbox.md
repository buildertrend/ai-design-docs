# BdsCheckbox / BdsCheckboxGroup

## Intent
Allow users to turn individual options on or off independently. Use a single `BdsCheckbox` for a standalone toggle. Use `BdsCheckboxGroup` to group multiple related checkboxes under a shared legend with proper accessibility structure.

## Use when
- **BdsCheckbox:** Toggling a single on/off option (e.g., "Send email notification").
- **BdsCheckboxGroup:** Selecting one or more options from a related set (2–5 options).

## Avoid when
- Only one option can be selected — use `BdsRadioGroup`.
- There are more than 5 options — use `BdsSelect` with `multiple={true}`.
- The checkbox triggers a workflow action (e.g., "Mark Complete") — use an action button instead.

---

## States

### BdsCheckbox states

| State | Description |
|---|---|
| Unselected | Default. |
| Selected | `checked={true}`. |
| Indeterminate | Partially selected (used for "select all" controls where some children are checked). |
| Focused | Keyboard focus. |
| Read-only | `readOnly={true}` — value is visible but not changeable. |
| Disabled | `disabled={true}` — not interactive. |
| Validation | Error or warning message displayed below the checkbox. |

### BdsCheckboxGroup states

Group-level states apply to all children simultaneously:
- Read-only (`readOnly`)
- Disabled (`disabled`)
- Validation message (displayed below the group)

---

## Anatomy

**BdsCheckbox:**
1. Checkbox input — toggles on/off
2. Option label — describes the option; clicking it also toggles the input

**BdsCheckboxGroup:**
1. Legend — describes the group's purpose
2. One or more `BdsCheckbox` children
3. Optional description — adds supporting detail
4. Validation message (when applicable) — positioned below the group

---

## Alignment

Labels align to the right of their inputs. The group legend can be aligned horizontally or vertically depending on the surrounding form layout.

- Match `labelAlign` to the rest of the form — do not mix horizontal and vertical field alignment within one form.
- When the legend is horizontal, the first checkbox aligns with the legend baseline.

---

## Content guidelines

- **Start each label with a distinct word** — makes options easier to scan.
- **Use consistent syntax** across all options in a group.
- **Use standard action verbs:** "Show," "Include," "Allow," "User can."
- If successive labels would start with the same verb (e.g., multiple "Allow…" labels), move the repeated verb into the group legend.
- Use sentence case — not title case.
- Labels should never wrap to a second line. If a label is too long, rewrite it to be concise.

---

## Basic usage

```tsx
// Single checkbox
<BdsCheckbox id="notifications" data-testid="notifications" checked={values.notifications} onChange={handleChange}>
  Email notifications
</BdsCheckbox>

// Checkbox group
<BdsCheckboxGroup id="notificationPreferences" testId="notificationPreferences" legend="Notifications">
  <BdsCheckbox id="email" data-testid="email" checked={values.email} onChange={handleChange}>
    Email
  </BdsCheckbox>
  <BdsCheckbox id="sms" data-testid="sms" checked={values.sms} onChange={handleChange}>
    SMS
  </BdsCheckbox>
  <BdsCheckbox id="push" data-testid="push" checked={values.push} onChange={handleChange}>
    Push
  </BdsCheckbox>
</BdsCheckboxGroup>
```

---

## Accessibility

- `BdsCheckboxGroup` renders a `fieldset`/`legend` structure — screen readers announce the group purpose before each option.
- Keyboard: `Spacebar` toggles selection; `Tab` moves between checkboxes.
- The option label is included in the clickable area (clicking the label also toggles the input).
- `readOnly` checkboxes remain focusable; `disabled` checkboxes are removed from focus order.

---

## Anti-patterns

- Using a checkbox to trigger a workflow action ("Mark Complete") — use a button.
- Using a single `BdsCheckbox` when only one of several options can be active — use `BdsRadioGroup`.
- More than 5 options in a group — use multi-select (`BdsSelect` with `multiple={true}`).
- Successive labels that start with the same word — move the repeated word into the legend.
- Wrapping long labels to a second line — rewrite the label instead.
