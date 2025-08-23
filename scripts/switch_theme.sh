#!/bin/bash

# A smart theme switcher for the dotfiles environment.
#
# Usage:
#   switch-theme          - Toggles between 'dark' and 'light' themes.
#   switch-theme dark     - Switches to the dark theme.
#   switch-theme light    - Switches to the light theme.

# The directory where this script is located, used to find set-theme.sh
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
SET_THEME_SCRIPT="$SCRIPT_DIR/set-theme.sh"
THEME_STATE_FILE="$HOME/.config/dotfiles_theme_state"

# Ensure the core theme script exists
if [ ! -f "$SET_THEME_SCRIPT" ]; then
    echo "Error: The main theme script was not found at $SET_THEME_SCRIPT"
    exit 1
fi

# Determine the target theme
TARGET_THEME=$1
if [ -z "$TARGET_THEME" ]; then
    # No argument provided, so toggle the theme
    CURRENT_THEME=$(cat "$THEME_STATE_FILE" 2>/dev/null)
    if [ "$CURRENT_THEME" = "dark" ]; then
        TARGET_THEME="light"
    else
        # Default to dark if state is light or file doesn't exist
        TARGET_THEME="dark"
    fi
    echo "Toggling theme to: $TARGET_THEME"
else
    # Use the provided argument
    echo "Setting theme to: $TARGET_THEME"
fi

# Run the main theme setting script
"$SET_THEME_SCRIPT" "$TARGET_THEME"

# If the script was successful, save the new state
if [ $? -eq 0 ]; then
    echo "$TARGET_THEME" > "$THEME_STATE_FILE"
    echo "Successfully switched theme."
else
    echo "Error: The theme script failed to run."
    exit 1
fi
