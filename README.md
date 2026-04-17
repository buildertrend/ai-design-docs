# ai-design-docs

Portable Blueprint Design System context for use outside of BTNet, shared Claude design skills, and Figma Make guidelines for AI-assisted design workflows.

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
├── skills/                # Claude Code skills for design workflows
└── .github/               # Contribution governance
```

---

## Contribution Workflow

1. Identify a gap, improvement, or design workflow to automate
2. Draft collaboratively (e.g., HackMD, Notion)
3. Convert to structured markdown in the relevant folder (`docs/`, `figma/`, `skills/`, etc.)
4. Submit a PR for review
5. Merge into the repo
6. AI tools consume updated docs; share new skills with the team to install

All changes go through pull requests. Use `CODEOWNERS` for domain ownership. Draft ideas outside the repo before opening a PR.
