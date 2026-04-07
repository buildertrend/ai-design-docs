# Spacing

## Intent
Provide a consistent spatial rhythm across the product using a fixed set of spacing tokens. All padding, margin, and gap values should map to a token — no arbitrary values.

## Use when
Setting padding, margin, gap, or any spatial relationship between elements.

## Avoid when
Using arbitrary pixel values not in this scale. Never hardcode spacing values.

---

## Spacing scale

All tokens are multiples of 4px (the base unit), with a few exceptions for fine-grained control.

| Token | Value | Common use |
|---|---|---|
| `0` | 0px | Explicit zero |
| `025` | 1px | Hairline separators |
| `05` | 2px | Tight icon-to-label gaps |
| `1` | 4px | Minimum internal padding, tight gaps |
| `1-2-5` | 5px | Rare — fine-tuned alignment |
| `1-5` | 6px | Compact element padding |
| `2` | 8px | Default tight padding, inline gaps |
| `3` | 12px | Common internal padding |
| `4` | 16px | Default component padding |
| `5` | 20px | Comfortable component padding |
| `6` | 24px | Section padding, card gaps |
| `6-5` | 26px | Rare — fine-tuned alignment |
| `7` | 28px | Slightly larger gaps |
| `8` | 32px | Section separation |
| `9` | 36px | Medium layout gaps |
| `10` | 40px | Large layout padding |
| `12` | 48px | Section-level spacing |
| `16` | 64px | Page-level margins |
| `20` | 80px | Large spacing between sections |
| `24` | 96px | Extra-large spacing |
| `25` | 100px | Layout-level spacing |
| `28` | 112px | — |
| `30` | 120px | — |
| `32` | 128px | — |

---

## Requirements

- Always use a spacing token — never a raw pixel value.
- The base unit is 4px. Most spacing decisions should use values on the 4px grid (`1`, `2`, `3`, `4`, `6`, `8`, `10`, `12`, `16`).
- Use fine-grained tokens (`025`, `05`, `1-2-5`, `1-5`) only when the 4px grid doesn't work — document why.

---

## Recommendations

- `4` (16px) is the default internal component padding.
- `2` (8px) for tight inline gaps (e.g. icon to label).
- `6` (24px) for gaps between cards or grouped content.
- `8` (32px) for separation between distinct sections.
- `16` (64px) for page-level margins and large structural gaps.

---

## Accessibility

- Ensure touch targets have at least `10` (40px) of tappable area on mobile.
- Don't use `025` or `05` spacing inside interactive elements — they're too tight for reliable touch interaction.

---

## Anti-patterns

- Using `15px`, `17px`, or other off-grid values — always round to the nearest token.
- Mixing token values and raw values in the same component.
- Using `0` spacing between elements that need visual breathing room.
