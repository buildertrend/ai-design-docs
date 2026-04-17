# rn-to-figma

A Claude Code skill that generates a Figma component from a BTMobile React Native source component and publishes a gap audit to Confluence.

## Prerequisites

- [Claude Code](https://claude.ai/code) installed
- [Figma Console MCP](https://www.figma.com/community/plugin/1454811434969076992/figma-mcp-console) installed and running
- Confluence MCP installed and running
- Both Figma files open before invoking the skill:
  - **Blueprint Base**
  - **Mobile Design System (React Native)**

## Installation

Open Terminal, navigate to `ai-design-docs`, then run:

```sh
cp -r skills/rn-to-figma ~/.claude/skills/
```

Restart Claude Code — new skills require a restart to be recognized.

## Usage

Type `/rn-to-figma` followed by the component name:

```
/rn-to-figma Button
/rn-to-figma BTBanner
/rn-to-figma BTSegmentedControl
```

The skill will ask you to confirm your BTMobile repo path and verify both Figma files are open before proceeding.

## What it produces

- A Figma component set in **Mobile Design System (React Native)** covering all component variants
- A gap audit page published to Confluence under `UX > RN component audit`
