# Color

## Intent
Communicate meaning, hierarchy, and brand through a consistent set of semantic color tokens. Color decisions should always reference a token, never a hardcoded hex value.

## Use when
Applying color to any UI element: backgrounds, text, icons, borders, status indicators, or interactive states.

## Avoid when
Using raw hex values or non-semantic color references. Never pick a color directly from the palette without going through a semantic token.

---

## Token structure

Color tokens follow this pattern:

```
--color-{category}-{role}-{prominence}-{interaction}
```

**Categories:**
- `bg` — backgrounds
- `text` — text
- `icon` — icons
- `border` — borders
- `gauge` — data visualization

---

## Semantic color aliases

These are the primary tokens to use. They map to the underlying palette and carry meaning.

### Brand
| Alias | Maps to | Use for |
|---|---|---|
| `brand.primary1` | Blue 90 | Primary brand color — buttons, links, key actions |
| `brand.primary2` | Teal 40 | Secondary brand accent |
| `brand.secondary1` | Red 50 | Brand secondary |
| `brand.secondary2` | Orange 25 | Brand accent |
| `brand.secondary3` | Blue 60 | Brand secondary action |

### Status
| Alias | Background | Foreground | Use for |
|---|---|---|---|
| `warning` | Yellow 10 | Yellow 70 | Caution states, warnings |
| `danger` | Red 10 | Red 70 | Errors, destructive actions |
| `info` | Blue 10 | Blue 70 | Informational states |
| `success` | Green 10 | Green 70 | Confirmation, completion |
| `default` | Gray 10 | Gray 70 | Neutral states |

### Base
| Alias | Use for |
|---|---|
| `base.background` | Page and surface backgrounds (Gray 0) |
| `base.foreground` | Primary text on light backgrounds (Gray 90) |

---

## Rules

- **On semantic backgrounds:** When placing text or icons on a colored background (brand, danger, success, warning), use the `on-` version of the content token (e.g. `--color-text-on-brand`) to ensure contrast.
- **Status colors are paired.** Always use the background and foreground tokens together — e.g. `danger.background` with `danger.foreground`.
- **Dark mode:** Dark mode variants exist for all status aliases. Use `dark.warning`, `dark.danger`, etc. when building for dark contexts.

---

## Accessibility

- Ensure text/background color pairs meet WCAG AA contrast ratio (4.5:1 for normal text, 3:1 for large text).
- The semantic token pairings (e.g. `warning.background` + `warning.foreground`) are designed to meet contrast requirements — don't swap them.
- Never use color as the only means of conveying information — pair with an icon, label, or pattern.

---

## Anti-patterns

- Hardcoding hex values — always use a token.
- Using `danger.foreground` text on a `warning.background` — status pairs must be used together.
- Using brand colors for status indicators — use the dedicated status tokens instead.
- Assuming a color is "close enough" — if there's no token for it, bring it to the design system team.
