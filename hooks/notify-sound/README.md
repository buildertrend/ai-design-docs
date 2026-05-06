# notify-sound

A Claude Code hook that plays a sound when Claude finishes a response or needs your attention.

Hooks fire on two events:
- **Stop** — Claude has finished and is waiting for your input
- **PermissionRequest** — Claude is asking for permission to run a tool

## Prerequisites

- macOS (uses `afplay`)
- [jq](https://jqlang.github.io/jq/) — `brew install jq`

## Install

```bash
bash install.sh
```

## Uninstall

```bash
bash uninstall.sh
```

Or manually: open `~/.claude/settings.json` and remove the entries from the `Stop` and `PermissionRequest` arrays that contain `afplay /System/Library/Sounds/Blow.aiff`.

## Changing the sound

Open `install.sh` and change the `SOUND` variable on line 5 to any sound file path you want.

macOS ships with these system sounds in `/System/Library/Sounds/`:

| File | Description |
|------|-------------|
| `Blow.aiff` | Default (wind blow) |
| `Bottle.aiff` | Glass bottle pop |
| `Frog.aiff` | Frog croak |
| `Funk.aiff` | Low thud |
| `Glass.aiff` | Glass clink |
| `Hero.aiff` | Ascending chime |
| `Morse.aiff` | Morse code beep |
| `Ping.aiff` | High ping |
| `Pop.aiff` | Soft pop |
| `Purr.aiff` | Purr |
| `Sosumi.aiff` | Classic Mac sound |
| `Submarine.aiff` | Sonar ping |
| `Tink.aiff` | Light tap |

You can also use any `.aiff`, `.mp3`, or `.wav` file by providing its full path:

```bash
SOUND="afplay /path/to/your/sound.mp3"
```

Preview a sound before installing:

```bash
afplay /System/Library/Sounds/Glass.aiff
```

If you've already installed and want to change the sound, run `uninstall.sh` first, update the `SOUND` variable in `install.sh`, then run `install.sh` again.
