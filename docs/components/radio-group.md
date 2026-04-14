# BdsRadioGroup

## Intent
Present a set of mutually exclusive options where exactly one must be selected. All options are visible at once, making it easy for users to compare choices before selecting.

## Use when
- Only one option can be chosen.
- There are 2–5 options.
- Options benefit from being visible simultaneously (vs. hidden in a dropdown).

## Avoid when
- Multiple options can be selected — use `BdsCheckboxGroup`.
- There are more than 5 options — use `BdsSelect` (single-select).
- The UI needs branching/form logic (e.g., toggling between "choose date" and "schedule item") — use a segmented control.

---

## Options

Options are provided as an array via the `options` prop:

```ts
options={[
  { value: "option1", label: "Option 1", disabled: false },
  { value: "option2", label: "Option 2", disabled: false },
  { value: "option3", label: "Unavailable", disabled: true },
]}
```

---

## Captions

Each option can include an optional description (caption). When using captions:
- Every option should have a caption — avoid mixing captioned and uncaptioned options in the same group.
- Do not apply a single description to the entire group when per-option captions are used.
- A validation message can still appear at the group level alongside per-option captions.

---

## States

| State | Description |
|---|---|
| Not selected | Default for each option. |
| Selected | The chosen option. |
| Focused | Keyboard focus on an option. |
| Read-only | `readOnly={true}` — selected value is visible but not changeable. |
| Disabled (option) | `disabled: true` on the option — visible but not selectable. |
| Disabled (group) | All options are non-interactive. |
| Validation | Error message displayed below the group. |

**Important:** Once a user selects an option, they can only switch to another option — they cannot deselect entirely. A radio group can start with no selection, but once an option is chosen that state is permanent until another option is picked or the form is reset.

---

## Alignment

- Option labels always align to the right of their radio inputs.
- The field label (legend) can be left-aligned or top-aligned.
- Be consistent with the rest of the form — do not mix top and inline label alignment within one form.

---

## Content guidelines

- Start each option label with a distinct word — makes options easier to scan.
- Use sentence case — not title case.
- Use standard action verbs: "Show," "Include," "Allow," "[User] can."
- Do not start successive labels with the same word — move the repeated word into the field label.
- Do not use ampersands — write "and" in full.

---

## Requirements

- `id` and `data-testid` are required.
- `options` array is required — never render individual radio inputs manually.
- `value` and `onChange` are required for controlled usage.
- Do not display a radio option in isolation — always use within a `BdsRadioGroup`.

---

## Accessibility

- The entire option (input + label) is clickable.
- Keyboard: `Tab` enters and exits the group; arrow keys move between options; `Spacebar` selects the focused option.
- `readOnly` options remain focusable and are announced by screen readers.
- The field label (legend) is announced before each option, giving context to the choice.

---

## Anti-patterns

- Using `BdsRadioGroup` when multiple selections are valid — use `BdsCheckboxGroup`.
- More than 5 options — use `BdsSelect` (single-select) instead.
- Mixing captioned and uncaptioned options in the same group.
- Rendering a standalone radio input without a `BdsRadioGroup` wrapper.
- Using the radio group for toggling between UI states (e.g., view modes) — use a segmented control.
