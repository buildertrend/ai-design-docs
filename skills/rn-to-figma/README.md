# rn-to-figma

A Claude Code skill that generates a Figma component from a React Native source component and publishes a gap audit to Confluence.

## Prerequisites

- Claude Code installed
- First-party Figma MCP connected
- Atlassian Rovo MCP connected (for Confluence)

## Installation

Open Terminal, navigate to `ai-design-docs`, then run:

```sh
cp -r skills/rn-to-figma ~/.claude/skills/
```

This will place the skill in your local Claude folder. Restart Claude Code — new skills require a restart for recognition.

## Usage

Type `/rn-to-figma` followed by the component name and optional Figma URL and BTMobile repo path:

```
/rn-to-figma BTBanner
/rn-to-figma BTBanner https://www.figma.com/design/... /Users/you/Dev/BTMobile
```

The skill will prompt for any missing inputs before proceeding.

## What it produces

- A Figma component set in **Mobile Design System (React Native)** covering all component variants
- A gap audit page published to Confluence under `UX > RN component audit`
