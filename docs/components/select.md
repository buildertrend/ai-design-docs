# BdsSelect

## Intent
Single or multi-select dropdown with built-in search and filtering. Supports flat lists, grouped options, and custom item rendering. Built on Ant Design's TreeSelect.

## Use when
- The user selects one item from a list of 6 or more options (fewer → use `BdsRadioGroup`).
- The user selects multiple items from a list.
- Options need to be grouped under headers.
- Options are loaded dynamically or are too numerous to display as radio buttons.

## Avoid when
- 2–5 single-choice options — use `BdsRadioGroup`.
- The user needs to enter a value not in the list — use `BdsInput` instead.

---

## Modes

| Prop | Value | Behavior |
|---|---|---|
| `multiple` | `false` (default) | Single selection. User picks one option; selecting another replaces the previous. |
| `multiple` | `true` | Multi-selection. User can select any number of options. Includes a "Select all" option. |

---

## Options data

Options are provided as an array of `BdsSelectItem` via the `treeData` prop.

```ts
// Flat list
treeData={[
  new BdsSelectItem({ name: "Option A", id: 1 }),
  new BdsSelectItem({ name: "Option B", id: 2 }),
]}

// Grouped (use children)
treeData={[
  new BdsSelectItem({
    name: "Group A", id: "groupA",
    children: [
      { name: "Option 1", id: 1 },
      { name: "Option 2", id: 2 },
    ]
  }),
]}
```

In grouped single-selects, clicking a group header does not select the group — only individual items are selectable. In grouped multi-selects, clicking a group header selects/deselects all children in that group.

---

## States

| State | How to set |
|---|---|
| Enabled | Default. |
| Read-only | `readOnly={true}` — displays the selected value as text; dropdown is disabled. |
| Disabled (item) | `disabled: true` on the `BdsSelectItem` — the option appears in the list but cannot be selected. Disabled items are excluded from search results. |

---

## Filtering

Built-in search filters options as the user types. Filtering is case-insensitive and matches on `item.title` by default.

- Override with `filterOn` to filter on a different property (e.g., `(item) => item.extraData.searchValue`).
- Set `shouldFilterOptions={false}` to handle filtering externally (e.g., server-side search).
- `filterMode={true}` — multi-select displays "All Selected" when every option is checked. Use for filter UIs where selecting all is a meaningful state.

---

## Custom item rendering

Use `customItemRender` to display custom JSX for each option — avatars, badges, icons. The render function receives a `BdsSelectItem` and returns a `ReactNode`.

Use `BdsSelectCustomItemContext` to render differently in the input vs. the dropdown popover (e.g., show a badge in the input, show full detail in the dropdown).

`customItemRender` is assumed to be a **pure function**. Do not reference props or state directly — pass any required data via `extraData` on the `BdsSelectItem`.

---

## Requirements

- `id`, `data-testid`, `onChange`, `onBlur` are all required.
- `onChange` must be `setFieldValue` (or a compatible wrapper) — do not pass Formik's `handleChange`.
- `onBlur` must be `setFieldTouched` — note: `onBlur` does not fire when removing tags via the X icon in multi-select.
- Always wrap in `BdsFormItem` for label and validation message handling.

---

## Recommendations

- Set `getPopupContainer` to `(triggerNode) => triggerNode.parentElement ?? document.body` to prevent the dropdown from clipping inside overflow-hidden containers.
- Set `boundary` to the modal/panel query selector when used inside a constrained container.
- `dropdownCanExpand={false}` fixes the dropdown width to match the input — use when dynamic width causes layout issues.
- `disableVirtualScroll={true}` enables dynamic dropdown width — only use when virtual scrolling is not needed (large lists should keep virtual scrolling).

---

## Accessibility

- The combobox role is applied automatically.
- `ariaLabel` is required when the select does not have an associated `BdsFormItem` label.
- Keyboard: type to filter, arrow keys to navigate, Enter to select.

---

## Anti-patterns

- Using `BdsSelect` for 2–5 single-choice options — use `BdsRadioGroup`.
- Passing Formik's `handleChange` to `onChange` — use `setFieldValue`.
- Using a plain HTML `<select>` — bypasses BDS styling, grouping, multi-select, and filtering.
- Omitting `BdsFormItem` — leaves the select without a visible label.
- Mutating `treeData` items directly — create new `BdsSelectItem` instances instead.
