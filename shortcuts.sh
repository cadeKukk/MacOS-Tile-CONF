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
# Join lines that end in a backslash, so a multi-line binding is read as one
awk '{ if (sub(/\\[[:space:]]*$/, "")) { printf "%s", $0 } else { print } }' "$CONFIG_FILE" | while IFS= read -r line; do
    # Skip commented lines and empty lines
    if [[ "$line" =~ ^[[:space:]]*# || "$line" =~ ^[[:space:]]*$ ]]; then
        continue
    fi

    # Only lines of the form "keys : command" are bindings
    if [[ "$line" != *:* ]]; then
        continue
    fi

    # Split at the first colon only; the command may contain colons itself
    shortcut=$(printf '%s' "${line%%:*}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    action=$(printf '%s' "${line#*:}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//;s/[[:space:]][[:space:]]*/ /g')

    # Only process valid shortcuts
    if [ -n "$shortcut" ] && [ -n "$action" ]; then
        printf '%b%s%b → %b%s%b\n' "$YELLOW" "$shortcut" "$NC" "$GREEN" "$action" "$NC"
    fi
done

echo -e "\n${BLUE}${BOLD}=== End of Shortcuts ===${NC}"
echo -e "\nTo modify these shortcuts, edit: ${CYAN}~/.config/skhd/skhdrc${NC}" 