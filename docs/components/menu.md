# BuiMenu

## Intent
Provide styled dropdown menu content. `BuiMenu` is used as the overlay content inside an antd `Dropdown` — it is not a standalone navigation component.

## Use when
- An overflow menu or contextual action menu is needed (e.g., the ⋯ overflow on a toolbar or table row).
- Collapsed breadcrumb items need to be surfaced in a dropdown on mobile.

## Avoid when
- The menu items are primary navigation — use the application's nav structure instead.
- Only one action is available — show it as a button directly, not in a menu.

---

## Structure

`BuiMenu` is always used as the `overlay` of an antd `Dropdown`. Use `BuiMenu.Item` for individual items and `BuiMenu.SubMenu` for nested groups.

```tsx
<Dropdown
  overlay={
    <BuiMenu testid="actions-menu">
      <BuiMenu.Item testid="edit">Edit</BuiMenu.Item>
      <BuiMenu.Item testid="print">Print</BuiMenu.Item>
      <BuiMenu.SubMenu testid="more" title="More">
        <BuiMenu.Item testid="void">Void</BuiMenu.Item>
      </BuiMenu.SubMenu>
    </BuiMenu>
  }
  trigger={["click"]}
>
  <BuiButton type="tertiary" icon={<BdsIconDotsThree />} aria-label="More actions" />
</Dropdown>
```

---

## Keyboard accessibility

Always use the `useMenuFocusOnOpen` hook when combining `BuiMenu` with a `Dropdown`. Without it, antd Dropdown does not transfer focus into the menu when it opens — keyboard users cannot navigate items with arrow keys or close the menu with Escape.

```tsx
const { handleVisibleChange } = useMenuFocusOnOpen({
  triggerRef,
  visible,
  onVisibleChange: setVisible,
});
```

The hook handles focus transfer between the trigger and menu, enabling rc-menu's built-in keyboard navigation (arrow keys, Enter, Home/End, type-ahead).

---

## Requirements

- `testid` is required on `BuiMenu`, `BuiMenu.Item`, and `BuiMenu.SubMenu`.
- Always use `useMenuFocusOnOpen` for keyboard accessibility.
- `BuiMenu` must be used as a `Dropdown` overlay — never rendered standalone.

---

## Overflow menu ordering (when used as an action menu)

Follow the standard overflow order from the purpose-driven states pattern:

1. Workflow actions (Recall, etc.)
2. Common actions (Print, Share)
3. Destructive actions (Delete, Void) — styled with `secondarydanger`, always last, separated by a divider

---

## Accessibility

- The trigger button for an overflow menu must have `aria-label` (e.g., `"More actions"`).
- `useMenuFocusOnOpen` is required — without it, the menu is not keyboard navigable.
- Keyboard: arrow keys navigate items; `Enter` activates; `Escape` closes and returns focus to the trigger.

---

## Anti-patterns

- Rendering `BuiMenu` without a `Dropdown` wrapper.
- Omitting `useMenuFocusOnOpen` — leaves the menu inaccessible to keyboard users.
- Using `BuiMenu` for primary page navigation.
- Placing a menu with only one item — show the action as a button directly.
- Omitting `aria-label` on the trigger button.
