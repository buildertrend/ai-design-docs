#!/bin/bash
set -e

SETTINGS="$HOME/.claude/settings.json"
SOUND="afplay /System/Library/Sounds/Blow.aiff"

if ! command -v jq &> /dev/null; then
  echo "Error: jq is required. Install it with: brew install jq"
  exit 1
fi

if [ ! -f "$SETTINGS" ]; then
  echo "No settings file found at $SETTINGS — nothing to remove"
  exit 0
fi

jq --arg cmd "$SOUND" '
  .hooks.Stop = [.hooks.Stop[]? | select(any(.hooks[]; .command == $cmd) | not)] |
  .hooks.PermissionRequest = [.hooks.PermissionRequest[]? | select(any(.hooks[]; .command == $cmd) | not)]
' "$SETTINGS" > /tmp/claude-settings-tmp.json && mv /tmp/claude-settings-tmp.json "$SETTINGS"

echo "notify-sound hooks removed"
