# BuiTabs

## Intent
Switch between different views of the same data or subject matter on a single page. Tabs keep the user in context — they are not navigation between distinct features or pages.

## Use when
- Showing different views of the same data (e.g., saved/filtered table views, internal vs. client-facing view).
- The content in each tab is related to the same subject and the user may want to switch between views frequently.

## Avoid when
- The choice affects how the user interacts with or inputs into the page (e.g., switching between flat fee and line-item pricing, or choosing a date vs. linking to the schedule) — use a **segmented control** instead.
- The tabs would switch between distinct product features (e.g., Bills and Purchase Orders) — those should be accessible through navigation, not combined on one page with tabs.
- Nesting tabs inside a tab panel — never stack multiple rows of tab-like controls.

---

## Structure

Use `BuiTabs` as the container and `BuiTabs.TabPane` for each tab's content.

```tsx
<BuiTabs testid="invoice-tabs" activeKey={activeTab} onChange={setActiveTab}>
  <BuiTabs.TabPane tab="Details" key="details">
    {/* details content */}
  </BuiTabs.TabPane>
  <BuiTabs.TabPane tab="History" key="history">
    {/* history content */}
  </BuiTabs.TabPane>
</BuiTabs>
```

---

## Icons

If any tab has an icon, all tabs must have icons — never mix tabs with and without icons in the same group.

---

## Disabled tabs

Do not use the `disabled` prop on a tab pane. If a tab should be unavailable, do not render it. Disabled tabs create confusion about whether the feature exists but is locked, or simply isn't applicable.

---

## Mobile behavior

When tabs overflow the available horizontal space at smaller viewports, the tab bar scrolls horizontally. Design for this — avoid tabs with very long labels that will force excessive scrolling on mobile.

---

## Requirements

- `testid` is required.
- `type` and `size` props from antd are intentionally excluded from `BuiTabs` — do not attempt to use them. If size adjustment is needed, use spacing and font-size tokens directly.
- Each `BuiTabs.TabPane` requires a unique `key`.

---

## Recommendations

- Use `destroyInactiveTabPane={true}` sparingly — it re-mounts tab content on each switch, which can cause data loss or poor performance. Default (false) keeps all panes mounted.
- `tabBarExtraContent` can be used to place actions (e.g., a filter or settings button) in the tab bar's right slot.

---

## Accessibility

Follows WAI-ARIA guidelines for accessible tab navigation.

| Key | Action |
|---|---|
| `Tab` | Move focus into/out of the tablist (only the active tab is focusable within the list) |
| `Arrow Right` / `Arrow Left` | Navigate between tabs (horizontal) |
| `Arrow Down` / `Arrow Up` | Navigate between tabs (vertical, when `tabPosition` is left/right) |
| `Home` | Jump to first tab |
| `End` | Jump to last tab |

Navigation wraps — pressing Right on the last tab moves focus to the first tab.

---

## Anti-patterns

- Using tabs for mode selection (pricing type, input method) — use a segmented control.
- Using tabs to switch between distinct product features — use separate pages and navigation.
- Nesting a tab panel inside another tab panel.
- Mixing tabs with and without icons.
- Using the `disabled` prop on a tab pane — omit the pane instead.
- Using `type` or `size` props — they are not exposed by `BuiTabs`.
