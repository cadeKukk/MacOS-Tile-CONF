#!/bin/bash

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

clear
echo -e "${BLUE}${BOLD}=== Yabai Keyboard Shortcuts ===${NC}\n"

if [ ! -f ~/.config/skhd/skhdrc ] && [ ! -f ./skhdrc ]; then
    echo -e "${RED}Error: Could not find skhdrc file.${NC}"
    echo "Please make sure either ~/.config/skhd/skhdrc or ./skhdrc exists."
    exit 1
fi

# Determine which file to use
if [ -f ~/.config/skhd/skhdrc ]; then
    CONFIG_FILE=~/.config/skhd/skhdrc
else
    CONFIG_FILE=./skhdrc
fi

echo -e "${CYAN}Showing shortcuts from: ${CONFIG_FILE}${NC}\n"

# Parse the shortcuts file and display in a nice format
grep -v '^#' "$CONFIG_FILE" | grep -v '^$' | while read -r line; do
    # Skip commented lines and empty lines (more robust check)
    if [[ "$line" =~ ^[[:space:]]*# || "$line" =~ ^[[:space:]]*$ ]]; then
        continue
    fi
    
    # Extract shortcut and action
    shortcut=$(echo "$line" | awk -F ':' '{print $1}' | sed 's/^ *//;s/ *$//')
    action=$(echo "$line" | awk -F ':' '{print $2}' | sed 's/^ *//;s/ *$//')
    
    # Only process valid shortcuts
    if [ -n "$shortcut" ] && [ -n "$action" ]; then
        echo -e "${YELLOW}${shortcut}${NC} → ${GREEN}${action}${NC}"
    fi
done

echo -e "\n${BLUE}${BOLD}=== End of Shortcuts ===${NC}"
echo -e "\nTo modify these shortcuts, edit: ${CYAN}~/.config/skhd/skhdrc${NC}" 