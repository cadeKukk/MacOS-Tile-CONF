# Yabai Installer 🪟

![Yabai Logo](assets/yabai-logo.png)

> A simple, comprehensive guide to install [Yabai](https://github.com/koekeishiya/yabai) - the powerful tiling window manager for macOS.

## 📋 Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
  - [Step 1: Install Homebrew](#step-1-install-homebrew)
  - [Step 2: Install Yabai](#step-2-install-yabai)
  - [Step 3: Install SKHD (Simple Hotkey Daemon)](#step-3-install-skhd)
  - [Step 4: Copy Configuration Files](#step-4-copy-configuration-files)
  - [Step 5: Start the Services](#step-5-start-the-services)
- [Configuration](#configuration)
- [Keyboard Shortcuts](#keyboard-shortcuts)
- [Troubleshooting](#troubleshooting)
- [Updating](#updating)
- [Uninstalling](#uninstalling)
- [Scripts](#scripts)

## 🔧 Requirements
- macOS Big Sur (11.0) or later
- Administrator access
- Terminal knowledge (basic)

## 🚀 Installation

### Step 1: Install Homebrew
Homebrew is a package manager for macOS that we'll use to install Yabai.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installation, follow the instructions in the terminal to add Homebrew to your PATH.

### Step 2: Install Yabai

```bash
brew install koekeishiya/formulae/yabai
```

### Step 3: Install SKHD (Simple Hotkey Daemon)
SKHD allows you to define keyboard shortcuts to control Yabai.

```bash
brew install koekeishiya/formulae/skhd
```

### Step 4: Copy Configuration Files
Create the configuration directories if they don't exist:

```bash
mkdir -p ~/.config/yabai
mkdir -p ~/.config/skhd
```

Copy the configuration files:

```bash
# Copy the yabairc config
cp ./yabairc ~/.config/yabai/yabairc
chmod +x ~/.config/yabai/yabairc

# Copy the skhdrc config
cp ./skhdrc ~/.config/skhd/skhdrc
```

### Step 5: Start the Services

```bash
# Start yabai
brew services start yabai

# Start skhd
brew services start skhd
```

## ⚙️ Configuration
The default configuration files included in this repository provide:

- Tiling window management
- Window shortcuts for navigation, resizing, and reorganizing
- Space (desktop) management
- Multi-monitor support

### Customizing Yabai (yabairc)
Edit the configuration file:
```bash
nano ~/.config/yabai/yabairc
```

### Customizing Shortcuts (skhdrc)
Edit the configuration file:
```bash
nano ~/.config/skhd/skhdrc
```

## ⌨️ Keyboard Shortcuts
The default shortcuts configuration includes:

| Shortcut | Action |
|----------|--------|
| `ctrl + cmd - a/s/w/d` | Focus window (west/south/north/east) |
| `ctrl + shift - a/s/w/d` | Move window (west/south/north/east) |
| `ctrl - a/s/w/d` | Resize window (left/down/up/right) |
| `ctrl - space` | Toggle float for focused window |
| `ctrl - l` | Rotate layout 90° |
| `ctrl - k` | Balance layout |
| `ctrl - f` | Toggle fullscreen for focused window |
| `ctrl + alt - 1-9` | Move window to space 1-9 |

> 📝 Use the included `shortcuts.sh` script to view all available shortcuts in a nicely formatted way:
> ```bash
> ./shortcuts.sh
> ```

## 🔍 Troubleshooting

### Yabai not working properly
1. Check if the services are running:
   ```bash
   brew services list
   ```

2. Check logs for errors:
   ```bash
   cat /usr/local/var/log/yabai/yabai.out.log
   cat /usr/local/var/log/yabai/yabai.err.log
   ```

3. Restart the services:
   ```bash
   brew services restart yabai
   brew services restart skhd
   ```

## 🔄 Updating

To update Yabai to the latest version:

```bash
brew update
brew upgrade yabai
brew upgrade skhd
```

## 🗑️ Uninstalling

If you want to completely remove Yabai and SKHD:

```bash
# Manual uninstallation
brew services stop yabai
brew services stop skhd
brew uninstall yabai
brew uninstall skhd
rm -rf ~/.config/yabai
rm -rf ~/.config/skhd
```

Or simply use the included uninstall script:

```bash
./uninstall.sh
```

## 📜 Scripts

This repository includes several helpful scripts:

- **install.sh**: Automated installer for Yabai and SKHD
- **uninstall.sh**: Removes Yabai, SKHD, and all configurations
- **shortcuts.sh**: Displays all configured keyboard shortcuts in a readable format

To use any script, first make it executable (if you haven't already):

```bash
chmod +x script_name.sh
```

Then run it:

```bash
./script_name.sh
```

---

## 📝 License
MIT License

## 🙏 Acknowledgements
- [koekeishiya](https://github.com/koekeishiya) for creating Yabai and SKHD
- All the contributors to the Yabai project 