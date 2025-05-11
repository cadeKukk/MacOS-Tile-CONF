#!/bin/bash

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colorful messages
print_message() {
    echo -e "${BLUE}[YABAI INSTALLER]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Print welcome message
clear
echo -e "${BLUE}"
echo "  __   __     _     ____       _     ___"
echo "  \ \ / /__ _| |__ |  _ \ __ _(_)   |_ _|_ __  ___  __ _| | | ___ _ __"
echo "   \ V / _ \` | '_ \| |_) / _\` | |    | || '_ \/ __|/ _\` | | |/ _ \ '__|"
echo "    | | (_| | |_) |  _ < (_| | |    | || | | \__ \ (_| | | |  __/ |"
echo "    |_|\__,_|_.__/|_| \_\__,_|_|   |___|_| |_|___/\__,_|_|_|\___|_|"
echo -e "${NC}"
echo -e "A simple installer for the Yabai tiling window manager on macOS\n"

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This installer only works on macOS."
    exit 1
fi

# Check macOS version
os_version=$(sw_vers -productVersion)
print_message "Detected macOS version: $os_version"

# Check if Homebrew is installed
print_message "Checking if Homebrew is installed..."
if ! command -v brew &> /dev/null; then
    print_message "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH (this is needed for the script to continue)
    if [[ -d "/opt/homebrew/bin" ]]; then
        # For Apple Silicon Macs
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d "/usr/local/bin" ]]; then
        # For Intel Macs
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    
    print_success "Homebrew installed successfully."
else
    print_success "Homebrew is already installed."
fi

# Install Yabai
print_message "Installing Yabai..."
brew install koekeishiya/formulae/yabai
print_success "Yabai installed successfully."

# Install SKHD
print_message "Installing SKHD (Simple Hotkey Daemon)..."
brew install koekeishiya/formulae/skhd
print_success "SKHD installed successfully."

# Create config directories
print_message "Creating configuration directories..."
mkdir -p ~/.config/yabai
mkdir -p ~/.config/skhd
print_success "Configuration directories created."

# Copy configuration files
print_message "Copying configuration files..."
cp ./yabairc ~/.config/yabai/yabairc
chmod +x ~/.config/yabai/yabairc
cp ./skhdrc ~/.config/skhd/skhdrc
print_success "Configuration files copied."

# Start services
print_message "Starting Yabai and SKHD services..."
brew services start yabai
brew services start skhd
print_success "Services started."

# Information about SIP
echo 
print_warning "IMPORTANT NOTE ABOUT SYSTEM INTEGRITY PROTECTION (SIP)"
echo "To enable advanced Yabai features like window borders and shadows,"
echo "you need to partially disable SIP. This requires rebooting into Recovery Mode."
echo
echo "Instructions:"
echo "1. Restart your Mac and hold Command (⌘) + R during startup to enter Recovery Mode"
echo "2. Open Terminal from the Utilities menu"
echo "3. Run: csrutil enable --without debug --without fs"
echo "4. Restart your Mac"
echo "5. Open Terminal and run: sudo nvram boot-args=-arm64e_preview_abi"
echo "6. Restart your Mac again"
echo
echo "For more information, visit: https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection"
echo

print_success "Yabai and SKHD installation completed!"
echo 
echo "You can now use Yabai with the default configuration."
echo "To customize, edit the following files:"
echo "  - ~/.config/yabai/yabairc"
echo "  - ~/.config/skhd/skhdrc"
echo
echo "To restart the services after making changes:"
echo "  brew services restart yabai"
echo "  brew services restart skhd"
echo
echo "Enjoy your new tiling window manager!" 