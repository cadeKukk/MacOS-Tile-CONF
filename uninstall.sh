#!/bin/bash

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colorful messages
print_message() {
    echo -e "${BLUE}[YABAI UNINSTALLER]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Print welcome message
clear
echo -e "${BLUE}"
echo "  __   __     _     ____       _   _   _       _           _        _ _           "
echo "  \ \ / /__ _| |__ |  _ \ __ _(_) | | | |_ __ (_)_ __  ___| |_ __ _| | | ___ _ __ "
echo "   \ V / _\` | '_ \| |_) / _\` | | | | | | '_ \| | '_ \/ __| __/ _\` | | |/ _ \ '__|"
echo "    | | (_| | |_) |  _ < (_| | | | |_| | | | | | | | \__ \ || (_| | | |  __/ |   "
echo "    |_|\__,_|_.__/|_| \_\__,_|_|  \___/|_| |_|_|_| |_|___/\__\__,_|_|_|\___|_|   "
echo -e "${NC}"
echo -e "This script will uninstall Yabai and SKHD from your system\n"

# Ask for confirmation
read -p "Are you sure you want to uninstall Yabai and SKHD? [y/N] " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    print_message "Uninstallation cancelled."
    exit 0
fi

# Stop services
print_message "Stopping Yabai and SKHD services..."
brew services stop yabai 2>/dev/null
brew services stop skhd 2>/dev/null
print_success "Services stopped."

# Uninstall packages
print_message "Uninstalling Yabai..."
brew uninstall yabai 2>/dev/null
print_success "Yabai uninstalled."

print_message "Uninstalling SKHD..."
brew uninstall skhd 2>/dev/null
print_success "SKHD uninstalled."

# Remove configuration files
print_message "Removing configuration files..."
rm -rf ~/.config/yabai 2>/dev/null
rm -rf ~/.config/skhd 2>/dev/null
print_success "Configuration files removed."

# Inform about SIP settings
print_warning "NOTE: If you modified SIP settings for Yabai, you may want to restore them."
echo "To restore default SIP settings:"
echo "1. Restart your Mac and hold Command (⌘) + R to enter Recovery Mode"
echo "2. Open Terminal from the Utilities menu"
echo "3. Run: csrutil enable"
echo "4. Restart your Mac"

print_success "Yabai and SKHD have been completely uninstalled from your system." 