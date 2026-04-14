# BuiButton

## Intent
Trigger actions. Buttons communicate what will happen when a user interacts with them and are the primary way users initiate workflows, submit data, and take destructive actions.

## Use when
- A user needs to take an action: save, submit, delete, send, export.
- The action is immediate or starts a process.

## Avoid when
- The action navigates to another page — use `BdsLink` instead.
- The UI needs a toggled active/inactive state — use a selectable `BdsButtonGroup`.
- The action is a text link within a sentence or paragraph — use `BdsLink`.

---

## Display types

| `type` | Appearance | When to use |
|---|---|---|
| `primary` | Filled, brand color | The single most important action in a view. **One per view.** |
| `secondary` | Outlined | Prominent but not the primary action — Filter, Export, Cancel. |
| `tertiary` | Ghost / no border | Low-attention utility actions. Never for navigation or sign-up prompts. |
| `danger` | Filled, red | Destructive, hard-to-reverse actions — Delete, Disconnect, Void. |
| `secondarydanger` | Outlined, red | Destructive actions in overflow menus only. |

`brandprimary` and `brandsecondary` are reserved for marketing contexts — do not use in product UI.

---

## Content variants

| Variant | How to implement |
|---|---|
| Text + icon | Place icon and text together in `children`: `<BuiButton type="secondary"><BdsIconSend /> Send</BuiButton>` |
| Text only | `children` with text only. |
| Icon only | Use the `icon` prop (antd API). Always requires `aria-label`. |

---

## States

| State | How to set |
|---|---|
| Enabled | Default. |
| Hover | Cursor over the button. |
| Pressed | Button is being clicked or tapped. |
| Focus | Keyboard navigation focus. |
| Disabled | `disabled` prop. |
| Loading | `loading` prop — disables the button and shows a spinner. Use after submit rather than disabling the button with no feedback. |

---

## Requirements

- Icon-only buttons must always include `aria-label`.
- `selected` is only valid for `type="tertiary"` — use it to indicate a toggled/active state.

---

## Recommendations

- Default `type` is `"primary"` — be explicit when using other types.
- Use `loading` after submit rather than `disabled` — it gives users feedback without removing the affordance.

---

## Accessibility

- Icon-only buttons **must** have `aria-label` — this is the accessible name for screen readers.
- `selected` on a tertiary button communicates toggled state; pair with `aria-pressed` if the button controls a visible toggle.

---

## Anti-patterns

- More than one `primary` button in a single view.
- Icon-only button without `aria-label`.
- Using `tertiary` for "Sign up" or "Forgot password?" — those should be inline text links (`BdsLink`).
- Using `secondarydanger` outside an overflow menu.
- Placing a `danger` Delete button as a standalone button in the header — always in overflow.
- Using `brandprimary` or `brandsecondary` in product UI.

---

# BdsButtonGroup

## Intent
Group related buttons with automatic responsive rollup. Collapses buttons into a dropdown at small screen sizes without requiring manual breakpoint handling. Also supports split-button and single-selection patterns.

## Use when
- A header or toolbar needs 2+ related actions that may not all fit at small screen sizes.
- You need a split button (one-click primary action + dropdown for alternatives).
- You need mutually exclusive button selection (segmented control pattern).

## Avoid when
- Buttons are unrelated — group only logically connected actions.

---

## Key behaviors

**Rollup:** At smaller widths, buttons collapse into a dropdown. Control this per-button with `minStage` and `maxStage` on `BdsRollupButton`:
- `minStage=1` — the button will never collapse into the dropdown.
- `maxStage=0` — the button is always in the dropdown.

**Split button:** `splitButton={true}` creates a primary button + dropdown caret. Use when an entity can be created in more than one way (e.g., import from template). Prefer split button over a dropdown primary button.

**Selectable:** `selectable={true}` ensures only one button in the group is active at a time. Use for mutually exclusive view or filter states.

**Compact:** `compact={true}` reduces spacing between buttons — use in dense toolbars.

**Boundary:** Set `boundary` on the group (not individual buttons) when the group is inside a modal or panel, to prevent the dropdown from clipping outside the container.

---

## Requirements

- Children must be `BdsRollupButton` components — **not** `BuiButton` or `BdsButton`. Using other button types inside a `BdsButtonGroup` will break rollup behavior.
- `boundary` must be set on the group itself, not on individual buttons.

---

## Anti-patterns

- Placing `BuiButton` or `BdsButton` components directly inside `BdsButtonGroup` — use `BdsRollupButton`.
- Using a dropdown primary button when a split button is the right pattern.
- Setting `boundary` on individual `BdsRollupButton` children instead of the group.
