# BTPopover

## Intent
Anchor a floating surface to a trigger element (usually an info icon) to show supplemental context without cluttering the page.

## Use when
- The information is supplemental or nice-to-know — e.g., explaining what a field means or why it's there.
- A button needs a hover label — wrap the `BTButton` in `BTPopover` with hover trigger. (BTButton has no built-in tooltip prop yet; a dedicated tooltip prop is planned.)

## Avoid when
- The information is essential to completing the task — use inline text or a banner.
- The content is a validation error — use inline validation on the field.
- A single form would need more than two popovers — simplify the UI first.
- Many elements need explanations — the interface is unclear; redesign it.

---

## Trigger types

Limit triggers to three types: the default info icon, a button, or underlined text.

| Context | Trigger | Notes |
|---|---|---|
| Form field | Info icon next to the label | Never make the label itself the trigger — it breaks input focus on mobile. |
| Column header | Header text with a dashed underline | Signals hover-to-reveal without adding an extra icon. |
| Button label | Wrap the `BTButton` in `BTPopover` | Use for icon-only buttons where the action isn't obvious. |

When no children are passed, `BTPopover` defaults to the info icon.

---

## Behavior

| `trigger` | When to use | Closes when… |
|---|---|---|
| `hover` (default) | Short, supplemental text. Keyboard users can also reach the popover by tabbing to the trigger. | Mouse leaves the trigger and popover area. |
| `click` | Interactive content (links, buttons, inputs), or dense layouts with multiple popovers — hover in dense areas feels noisy as users accidentally open popovers while moving their mouse. | User clicks the trigger again, or clicks anywhere outside. |

All popovers close on page scroll by default (`shouldCloseOnScroll={true}`). This prevents them from floating in the wrong spot after the page moves.

---

## Content

- **Without a title:** One sentence, max two. Explain *what* something means or *why* it's there.
- **With a title:** A short paragraph or a few bullet points. Links and formatted text are fine. If you need more than 3–4 lines, the content belongs inline on the page or in a help article.
- **Don't be redundant.** If the field is called "Markup %", don't open with "Markup percentage is…" — the user already knows what they clicked. If the popover doesn't add new information beyond what's visible, skip it.

---

## Width options

| `widthType` | Behavior | When to use |
|---|---|---|
| `"narrow"` (default) | Constrained width | Short text hints — most use cases. |
| `"wide"` | Wider max-width | Longer explanations or small tables. |
| `"unrestricted"` | No max-width | Content that sets its own width. |

---

## Placement

BTPopover supports all 12 placements and auto-adjusts when clipped by the viewport.

- Default to `top` or `bottom` in dense layouts — least likely to overlap adjacent content.
- Use `left` or `right` when the trigger sits at the edge of a row.
- Use corner variants (`topLeft`, `bottomRight`, etc.) to align the popover to the start or end of a wide trigger.

---

## Requirements

- Always pass `data-testid`. Used for automation tests, analytics, and accessibility tooling. Make it descriptive (e.g., `job-status-help-popover`, not `popover1`).
- Pass a unique `id` when multiple popovers can appear on the same page.
- Custom trigger elements must be keyboard-accessible. If you pass a custom child instead of using the default info icon, make sure it's focusable (a `BdsButton`, link, or element with `tabIndex={0}` and a `role`).

## Recommendations

- Default to the `hover` trigger — it's effortless to reveal.
- Switch to `click` in dense layouts or when the popover contains interactive content.
- Use **uncontrolled** mode (the default — BTPopover manages its own open/closed state) for the vast majority of cases.
- Use **controlled** mode (`visible` + `onVisibleChange`) only when you need outside control — e.g., a `TextTruncate` popover that opens only when text actually overflows, or closing the popover after a form submission.
- Set `stopPropagation` when the trigger sits inside a clickable row or card.
- `disabled` disables the popover without removing it from the DOM. The trigger still renders but the popover won't open.

## Platform notes

**Mobile / touch:**
- There is no hover on touch devices — tapping the info icon opens the popover automatically. No extra configuration needed.
- The default info icon is 20px. On dense mobile layouts, ensure enough surrounding space so users can tap it accurately.
- Tapping anywhere outside the popover closes it (same as clicking outside on desktop).
- Scroll closes the popover by default. This is the right behavior on mobile because content shifts quickly and an anchored popover would end up in the wrong place.

## Accessibility

- Keyboard users can reach hover popovers by tabbing to the trigger — this is built in.
- Screen readers announce the popover content when the trigger receives focus.
- The default info icon has a visible focus outline.

## Examples

### Form field — info icon inside the label

```tsx
<BTFormItemAutomatic
    id="markup"
    label={
        <>
            Markup %{" "}
            <BTPopover
                data-testid="markup-help"
                id="markup-help"
                content="Markup is applied to the builder cost to calculate the owner price."
            />
        </>
    }
>
    <BTInput id="markup" data-testid="markupInput" />
</BTFormItemAutomatic>
```

### Column header — underlined text

```tsx
<th>
    <BTPopover
        data-testid="actual-cost-column-help"
        id="actual-cost-column-help"
        content="Includes costs from bills, purchase orders, and direct costs that have been approved and synced."
    >
        <span
            style={{
                textDecoration: "underline",
                textDecorationStyle: "dashed",
                textUnderlineOffset: "3px",
                cursor: "pointer",
            }}
        >
            Actual cost
        </span>
    </BTPopover>
</th>
```

### Standalone — default info icon

```tsx
<BTPopover
    data-testid="sync-help"
    id="sync-help"
    content="Next sync is based on the schedule set in QuickBooks Web Connector."
/>
```

### Button label — wrap a `BTButton`

```tsx
<BTPopover content="Comments" placement="top">
    <BTButton
        type="tertiary"
        aria-label="Comment"
        data-testid="openCloseCommentDrawer"
        onClick={handleCommentsClick}
        selected={isCommentDrawerOpen}
    />
</BTPopover>
```

## Anti-patterns

- Wrapping a `<label>` in `BTPopover` — breaks input focus on mobile. Place the info icon inside the label fragment instead.
- Using a popover to hide essential information or validation errors.
- More than two popovers in a single form — simplify the UI first.
- Using `popover1`, `popover2` as `data-testid` values — make them descriptive.
- Custom triggers that aren't keyboard-focusable.
