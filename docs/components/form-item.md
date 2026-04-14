# BdsFormItem

## Intent
Wrap a form control (input, select, checkbox, radio group) with a consistently positioned label and validation message. Handles label–input association, alignment, and form context — so individual form components don't need to manage this themselves.

## Use when
Any form control needs a visible label. BdsFormItem is the standard label wrapper for all BDS form inputs.

## Avoid when
- The control is inside a table cell or a context where the label is provided by another mechanism (e.g., a column header).
- The control is standalone with no label — use `aria-label` directly on the input instead.

---

## Label alignment

| `labelAlign` | Layout | When to use |
|---|---|---|
| `left` | Label left, input right (vertically centered) | Standard horizontal form layout. |
| `leftTop` | Label left, input right (label top-aligned) | When the input can grow tall (e.g., textarea, multi-select with many tags). |
| `top` | Label above input | Stacked form layout; modal forms; narrow containers. |

Be consistent — **do not mix `labelAlign` values within a single form**. Choose one alignment and apply it uniformly.

---

## Requirements

- `id` and `data-testid` are required.
- `label` is required for all visible labels.
- `htmlFor` must match the `id` of the child input to ensure click-on-label behavior and screen reader association.

---

## Examples

**Standard text input with left label:**
```tsx
<BdsFormItem id="projectName" data-testid="projectName" label="Project name" labelAlign="left" htmlFor="project-name-input">
  <BdsInput id="project-name-input" data-testid="project-name-input" value={value} onChange={handleChange} />
</BdsFormItem>
```

**Stacked layout (top label):**
```tsx
<BdsFormItem id="description" data-testid="description" label="Description" labelAlign="top" htmlFor="description-input">
  <BdsTextArea id="description-input" data-testid="description-input" value={value} onChange={handleChange} onBlur={handleBlur} />
</BdsFormItem>
```

---

## Accessibility

- The `htmlFor` prop creates the accessible label association. Without it, screen readers cannot associate the label with the input.
- Validation messages rendered inside BdsFormItem are automatically positioned below the control and associated with it.

---

## Anti-patterns

- Mixing `labelAlign` values within the same form — creates visual inconsistency.
- Omitting `htmlFor` — breaks label–input association for keyboard and screen reader users.
- Using a raw `<label>` element instead of BdsFormItem — bypasses standardized spacing, alignment, and validation message handling.
