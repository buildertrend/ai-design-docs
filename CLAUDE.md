# AI Design System — Claude Code Instructions

This repository is the design intelligence layer for Blueprint Design System (BDS). It provides structured, AI-readable guidance for two consumers: **Claude Code** (code generation) and **Figma Make** (design generation).

---

## Documentation Hierarchy

| Layer | Path | Use for |
|---|---|---|
| Canonical docs | `docs/` | Source of truth. Detailed component specs, patterns, tokens. Use when generating or reviewing production code. |
| Figma Make guidance | `figma/` | Distilled, design-focused rules. Use when generating Figma designs or prototypes. |
| Task prompts | `prompts/` | Pre-written instructions for specific AI tasks. |
| Examples | `examples/` | Reference patterns (good) and anti-patterns (bad). |

---

## Interpretation Rules

1. **For Figma Make tasks** — load `figma/guidelines.md` as your primary context. It contains short, opinionated visual rules. Do not fall back to generic defaults.

2. **For code generation tasks** — load the relevant file(s) from `docs/` based on the component or pattern being built. Prefer BDS components over native HTML. Follow `docs/systems/` for tokens and `docs/components/` for component specs.

3. **Conflicts** — `figma/` and `docs/` may describe the same components differently (visual vs. technical). This is intentional. Use the layer appropriate to your task.

4. **When in doubt** — follow `docs/` as the authoritative source. `figma/` is a distillation of `docs/`, not a replacement.

---

## Key Files

- `figma/guidelines.md` — Figma Make design rules
- `docs/systems/` — Design tokens (spacing, color, typography) and utility classes
- `docs/components/` — Per-component guidance
- `docs/patterns/` — Multi-component UI patterns (forms, navigation, modals)
- `docs/principles/` — Foundational design principles
- `docs/platforms/` — Platform-specific guidance (web, iOS, Android, webview)
- `docs/hooks/` — BDS React hooks (useStore, etc.)
