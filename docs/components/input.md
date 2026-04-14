# BdsInput

## Intent
Single-line text input integrated with Formik. Handles value, change, and blur through Formik's `setFieldValue` and `setFieldTouched` — not native `onChange` and `onBlur`.

## Use when
- The user needs to enter free-form text, a number, email, or password.
- The field is part of a Formik-managed form.

## Avoid when
- Multi-line entry is needed — use `BdsTextArea`.
- The user selects from a predefined list — use `BdsSelect`.
- Numeric input with increment/decrement controls is needed — use `BdsNumberInput`.

---

## Input types

| `type` | Use for |
|---|---|
| `text` (default) | General text entry. |
| `number` | Numeric values where a plain number field is appropriate. |
| `email` | Email addresses — enables browser validation and mobile keyboard. |
| `password` | Sensitive input — masks the value. |
| `hidden` | Stores a value without displaying it. |

---

## States

| State | How to set |
|---|---|
| Enabled | Default. |
| Read-only | `readOnly={true}` — value is visible but not editable. Focusable (differs from disabled). |
| Disabled | `disabled={true}` — value is visible but not editable or focusable. |

Use `readOnly` in view mode (e.g., when an item is not in edit state). Use `disabled` only when the field is unavailable due to system state, not user permissions.

---

## Requirements

- `id` — ties the input to its `BdsFormItem` label via `htmlFor`.
- `data-testid` — required for automated testing.
- `onChange` — must be `setFieldValue` (or a compatible wrapper). Do not pass Formik's `handleChange`.
- `onBlur` — must be `setFieldTouched` (or a compatible wrapper). Do not pass Formik's `handleBlur`.

---

## Recommendations

- Always wrap in `BdsFormItem` for label and validation message handling.
- Use `autoFocus` only on the first field in a modal or primary form — not on inline fields in a page.
- `disableFormSubmit={true}` when the input is inside a line item container that should not submit the form on Enter.

---

## Accessibility

- The input is associated with its label via `BdsFormItem`'s `htmlFor` prop — always set both.
- `readOnly` inputs remain focusable; screen readers will announce the value. `disabled` inputs are skipped in focus order.

---

## Anti-patterns

- Passing Formik's `handleChange` to `onChange` — use `setFieldValue` instead.
- Passing Formik's `handleBlur` to `onBlur` — use `setFieldTouched` instead.
- Using a plain HTML `<input>` — bypasses BDS styling, validation, and Formik integration.
- Omitting `BdsFormItem` — leaves the input without a label, breaking accessibility and visual consistency.
