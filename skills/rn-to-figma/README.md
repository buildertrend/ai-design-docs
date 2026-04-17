# rn-to-figma

A Claude Code skill that generates a Figma component from a React Native source component and publishes a gap audit to Confluence.

## Prerequisites

- Claude Code installed
- Figma Console MCP installed and running
- Confluence MCP installed and running
- Both Figma files open before invoking the skill:
  - **Blueprint Base**
  - **Mobile Design System (React Native)**

## Installation

Open Terminal, navigate to `ai-design-docs`, then run:

```sh
cp -r skills/rn-to-figma ~/.claude/skills/
```

This will place the skill in your local Claude folder. Restart Claude Code - new skills require a restart for recognition.

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
- A gap audit page published to Confluence under `Product Design > Native Mobile > RN component audit`
