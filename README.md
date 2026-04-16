# ai-design-docs

Portable design intelligence layer for Blueprint Design System. The go-to BDS context for AI-assisted work outside of BTNet - powering Figma Make design generation and Claude Code in any codebase without its own design system docs.

---

## Folder Layout

```
ai-design-docs/
├── CLAUDE.md              # AI control plane — start here
├── docs/                  # Canonical source of truth
│   ├── principles/        # Accessibility, mobile-first, content
│   ├── systems/           # Tokens: typography, spacing, color
│   ├── components/        # Per-component specs
│   ├── patterns/          # Forms, navigation, modals, etc.
│   └── platforms/         # Web, iOS, Android, webview
├── figma/                 # Distilled guidance for Figma Make
├── prompts/               # Task-based AI instructions
├── examples/              # Good patterns and anti-patterns
└── .github/               # Contribution governance
```

---

## Contribution Workflow

1. Identify a gap or improvement
2. Draft collaboratively (e.g., HackMD, Notion)
3. Convert to structured markdown using the `_template.md` in the relevant `docs/` subfolder
4. Submit a PR for review
5. Merge into the repo
6. AI tools consume the updated content

All changes go through pull requests. Use `CODEOWNERS` for domain ownership. Draft ideas outside the repo before opening a PR.
