#!/bin/bash
set -e

SETTINGS="$HOME/.claude/settings.json"
SOUND="afplay /System/Library/Sounds/Blow.aiff"

if ! command -v jq &> /dev/null; then
  echo "Error: jq is required. Install it with: brew install jq"
  exit 1
fi

if [ ! -f "$SETTINGS" ]; then
  echo '{}' > "$SETTINGS"
fi

jq --arg cmd "$SOUND" '
  .hooks.Stop += [{"hooks": [{"type": "command", "command": $cmd}]}] |
  .hooks.PermissionRequest += [{"hooks": [{"type": "command", "command": $cmd}]}]
' "$SETTINGS" > /tmp/claude-settings-tmp.json && mv /tmp/claude-settings-tmp.json "$SETTINGS"

echo "notify-sound hooks installed"
