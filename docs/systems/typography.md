# Typography

## Intent
Establish a clear visual hierarchy through a consistent set of text styles. All type in the product should map to one of these styles — no ad-hoc font sizes or weights.

## Use when
Choosing text styles for any UI element: headings, body copy, labels, captions, and display text.

## Avoid when
Applying custom font sizes, weights, or families outside this system. Never hardcode font values.

---

## Text style scale

BDS defines three categories of text style, each with size variants.

### Normal — body and UI text (Inter)

| Token | Weight | Use for |
|---|---|---|
| `normal-sm` | Regular | Captions, helper text, metadata. Use sparingly. |
| `normal-md` | Regular | Default body text. Use for most content. |
| `normal-lg` | Regular | Supporting descriptions, subtitles. |

### Distinct — medium-emphasis text (Inter)

| Token | Weight | Use for |
|---|---|---|
| `distinct-sm` | Medium | **Form field labels** — always use this above inputs, never `normal-sm`. |
| `distinct-md` | Semibold | Section subheadings, emphasized UI labels. |
| `distinct-lg` | Semibold | Larger section headings. |

### Heavy — display and headings (Whyte)

| Token | Weight | Use for |
|---|---|---|
| `heavy-sm` | Regular | Smallest display text. |
| `heavy-md` | Bold | Mid-size headings. |
| `heavy-lg` | Bold | Section headings, modal titles (smaller contexts). |
| `heavy-xl` | Bold | Page titles, primary modal headings. |

---

## Hierarchy in practice

| Role | Token |
|---|---|
| Page or modal title | `heavy-xl` |
| Page subtitle / supporting description | `normal-lg` |
| Section heading | `heavy-lg` |
| Form field label (above an input) | `distinct-sm` — **never** `normal-sm` or `normal-md` |
| Body text | `normal-md` |
| Caption or helper text | `normal-sm` |

---

## Font families

| Family | Used for |
|---|---|
| Whyte | Display and heading text (`heavy-*` styles) |
| Inter | Body, labels, UI text (`normal-*` and `distinct-*` styles) |
| Roboto Mono | Code or monospaced text |

---

## Requirements

- Always use a token from the scale — never a raw font size or weight.
- Form field labels must use `distinct-sm`. Using `normal-sm` or `normal-md` makes labels visually indistinguishable from body copy.
- Page titles use `heavy-xl`. Section headings use `heavy-lg`. Never skip levels.
- Heavy styles use Whyte (brand font). Normal and distinct styles use Inter.

---

## Accessibility

- Maintain sufficient contrast between text and its background using the appropriate color token pair.
- Don't rely on font size alone to convey hierarchy — pair with weight and color.
- Minimum body text size is `normal-sm` (14px equivalent). Avoid going smaller.

---

## Anti-patterns

- Using `normal-sm` for form field labels — they disappear visually against body copy.
- Using `heavy-*` styles for body copy — reserved for display and headings only.
- Hardcoding font-size or font-weight values outside the token system.
- Using the same text style for both a heading and its supporting body text.
