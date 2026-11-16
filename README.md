# MacOS-Tile-CONF

A [yabai](https://github.com/asmvik/yabai) and [skhd](https://github.com/asmvik/skhd) configuration for tiling windows on macOS from the keyboard, with scripts to install it, remove it and list its shortcuts. yabai arranges the windows; skhd turns key presses into yabai commands.

![Diagram: three windows tiled with 12 px gaps, the focused one outlined in blue with W, A, S and D keys marked north, west, south and east. Beside it, the main bindings: ctrl + cmd + WASD focuses, ctrl + shift + WASD moves, ctrl + WASD resizes, ctrl + L rotates, ctrl + K balances, ctrl + F zooms to fullscreen, ctrl + space floats.](docs/layout-keys.png)

*A diagram of the layout and the main bindings, drawn from [yabairc](yabairc) and [skhdrc](skhdrc). It is not a screenshot.*

## What's in the repository

| File | What it is |
|------|------------|
| [yabairc](yabairc) | yabai settings: bsp layout, 12 px padding and gaps, new windows open as the second child, `fn` + drag to move or resize, and 13 apps left unmanaged (System Settings, Finder, Calculator, Activity Monitor and others) |
| [skhdrc](skhdrc) | The keyboard shortcuts listed below |
| [install.sh](install.sh) | Installs Homebrew if missing, installs yabai and skhd, copies both files into `~/.config` and starts both services |
| [uninstall.sh](uninstall.sh) | Asks for confirmation, then removes yabai, skhd and both config folders |
| [shortcuts.sh](shortcuts.sh) | Prints every binding in the installed `skhdrc`, or the one in this folder if none is installed |
| [docs/shortcuts.txt](docs/shortcuts.txt) | A short plain-text list of the window shortcuts |

## Requirements

- macOS Big Sur (11) or later, which is what the yabai formula asks for
- [Homebrew](https://brew.sh)
- Accessibility permission for yabai and skhd (System Settings > Privacy & Security > Accessibility)
- For the shortcuts that create, remove or send windows to spaces: System Integrity Protection partially disabled and yabai's scripting addition loaded. See [Spaces and the scripting addition](#spaces-and-the-scripting-addition).

## Install

```bash
git clone https://github.com/cadeKukk/MacOS-Tile-CONF.git
cd MacOS-Tile-CONF

brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

mkdir -p ~/.config/yabai ~/.config/skhd
cp ./yabairc ~/.config/yabai/yabairc
chmod +x ~/.config/yabai/yabairc
cp ./skhdrc ~/.config/skhd/skhdrc

yabai --start-service
skhd --start-service
```

`./install.sh` runs the same steps from inside the cloned folder.

The two formulas don't define a Homebrew service, so yabai and skhd are started with their own `--start-service` option rather than `brew services start`. Each one writes a launchd agent to `~/Library/LaunchAgents` and starts at login.

After editing either file, reload it:

```bash
yabai --restart-service
skhd --restart-service
```

## Try it

With three ordinary app windows open:

1. Press `ctrl + cmd + d` to focus the window to the east.
2. Press `ctrl + shift + s` to move the focused window south.
3. Press `ctrl + l` to rotate the layout, then `ctrl + k` to balance it.
4. Press `ctrl + space` to float the focused window, and again to tile it.

## Keyboard shortcuts

Every active binding in [skhdrc](skhdrc).

### Windows

| Shortcut | Action |
|----------|--------|
| `ctrl + cmd - a/s/w/d` | Focus the window to the west / south / north / east |
| `ctrl + shift - a/s/w/d` | Move the focused window west / south / north / east |
| `ctrl - a/s/w/d` | Push one edge of the focused window 100 px left / down / up / right |
| `ctrl - space` | Float or tile the focused window |
| `ctrl - f` | Zoom the focused window to fill the screen, or back |
| `ctrl + shift - x/z/c` | Send the focused window to display 1 / 2 / 3 and follow it |

### Layout

| Shortcut | Action |
|----------|--------|
| `ctrl - l` | Rotate the layout 90° |
| `ctrl - k` | Balance window sizes |
| `ctrl - j` | Switch the space to the stack layout |
| `ctrl - h` | Switch the space between bsp and float (uses `jq`) |
| `ctrl - g` | Toggle padding and gaps on the space |
| `ctrl - y` | Set all padding and the window gap to 0 |
| `ctrl - u` | Set the window gap back to 12 |
| `ctrl - o` / `ctrl - p` | Turn focus-follows-mouse on (autofocus) / off |

### Spaces

These need the scripting addition.

| Shortcut | Action |
|----------|--------|
| `ctrl + alt - 1` to `9` | Send the focused window to space 1 to 9 and follow it |
| `ctrl - n` | Create a space on the active display |
| `ctrl - m` | Remove the focused space |
| `ctrl + alt + shift - d` | Remove every empty space that isn't focused (uses `jq`) |

### Apps and extras

| Shortcut | Action | Needs |
|----------|--------|-------|
| `ctrl - return` | Open Alacritty, or a new Alacritty window if it is running | Alacritty |
| `ctrl + shift - return` | Open Firefox | Firefox |
| `ctrl + cmd - return` | Open `~/Downloads` | |
| `ctrl - e` | Launch a new instance of Safari | |
| `ctrl - r` | Switch audio output to "MacBook Pro Speakers" | `SwitchAudioSource` |
| `ctrl + alt + cmd - l` | Download the audio of the URL on the clipboard to `~/Downloads` | `yt-dlp` |
| `ctrl + alt + cmd - r` | Restart yabai | |

skhd takes these keys in every app, so the plain `ctrl` bindings replace the usual `ctrl - a`, `ctrl - e`, `ctrl - k` and similar editing keys in terminals and text fields. Change the modifier in `~/.config/skhd/skhdrc` if you rely on those.

To print the bindings from the terminal:

```bash
./shortcuts.sh
```

## Spaces and the scripting addition

`yabairc` runs `sudo yabai --load-sa` on start and again whenever the Dock restarts. That loads yabai's scripting addition, which yabai needs to create and remove spaces and, on recent macOS versions, to send a window to another space. It takes two things:

1. System Integrity Protection partially disabled. Follow yabai's guide: [Disabling System Integrity Protection](https://github.com/asmvik/yabai/wiki/Disabling-System-Integrity-Protection).
2. A sudoers entry so `sudo yabai --load-sa` can run without a password: [Configure scripting addition](https://github.com/asmvik/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition).

Without them yabai still tiles, focuses, moves and resizes windows, and its error log shows a sudo password error from that line each time `yabairc` loads.

## Troubleshooting

Check that both are running:

```bash
pgrep -lx yabai
pgrep -lx skhd
```

Read the logs:

```bash
cat /tmp/yabai_$USER.err.log
cat /tmp/skhd_$USER.err.log
```

If a shortcut does nothing, check that yabai and skhd are both listed under Accessibility in System Settings, then restart them with the commands under [Install](#install).

`cannot locate a bsp node fence` in skhd's log after a resize is expected: each resize binding tries two edges of the window, and one of them has no neighbour.

## Updating

```bash
brew update
brew upgrade yabai skhd
yabai --restart-service
skhd --restart-service
```

## Uninstalling

```bash
yabai --uninstall-service
skhd --uninstall-service
brew uninstall yabai skhd
rm -rf ~/.config/yabai ~/.config/skhd
```

`./uninstall.sh` does the same after asking for confirmation.

## License

MIT. See [LICENSE](LICENSE).

## Acknowledgements

yabai and skhd are written by [Åsmund Vikane](https://github.com/asmvik).
