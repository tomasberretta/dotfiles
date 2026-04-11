#!/bin/bash
# =============================================================================
# CENTRALIZED COLOR PALETTE
# =============================================================================
# Single source of truth for all color definitions used across:
# - Neovim
# - Ghostty terminal
# - Tmux status bar
# - Starship prompt
# - Fish shell
# - Sketchybar

# =============================================================================
# DARK THEME (IntelliJ New UI Dark)
# =============================================================================
DARK_BG="#1e1f22"              # Main background
DARK_FG="#bcbec4"              # Primary text
DARK_SURFACE="#2b2d30"         # Surface elements (panels, toolbars)
DARK_HIGHLIGHT="#2d2f34"       # Highlight background (current line)
DARK_GRAY="#6f737a"            # Secondary elements (comments, line numbers)
DARK_BLACK="#1e1f22"           # Darker elements
DARK_BORDER="#393b40"          # Borders, separators

# Dark accent colors
DARK_BLUE="#56a8f5"            # Functions, links
DARK_GREEN="#6aab73"           # Strings, success
DARK_TEAL="#c77dbb"            # Types, constants
DARK_PURPLE="#c77dbb"          # Types (same as pink in IJ)
DARK_RED="#f75464"             # Errors, deletions
DARK_YELLOW="#f2c55c"          # Warnings, search highlights
DARK_ORANGE="#cf8e6d"          # Keywords
DARK_CYAN="#2aacb8"            # Numbers, special values

# =============================================================================
# LIGHT THEME (IntelliJ New UI Light)
# =============================================================================
LIGHT_BG="#f7f8fa"             # Main background
LIGHT_FG="#080808"             # Dark text
LIGHT_SURFACE="#eef0f3"        # Light surface
LIGHT_HIGHLIGHT="#d4e2ff"      # Selection highlight
LIGHT_GRAY="#8c8c8c"          # Medium gray for secondary elements
LIGHT_BLACK="#080808"          # Dark elements

# Light accent colors
LIGHT_BLUE="#0065cf"           # Functions
LIGHT_GREEN="#067d17"          # Strings
LIGHT_TEAL="#9f0071"           # Types, constants
LIGHT_PURPLE="#871094"         # Types
LIGHT_RED="#cf3737"            # Errors
LIGHT_YELLOW="#9e880d"         # Warnings
LIGHT_ORANGE="#cf6a21"         # Keywords
LIGHT_CYAN="#2aacb8"           # Numbers

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

# Get color value for current theme
get_color() {
    local color_name=$1
    local theme=${2:-$(get_current_theme)}

    if [ "$theme" = "light" ]; then
        case $color_name in
            "bg") echo "$LIGHT_BG" ;;
            "fg") echo "$LIGHT_FG" ;;
            "surface") echo "$LIGHT_SURFACE" ;;
            "highlight") echo "$LIGHT_HIGHLIGHT" ;;
            "gray") echo "$LIGHT_GRAY" ;;
            "black") echo "$LIGHT_BLACK" ;;
            "blue") echo "$LIGHT_BLUE" ;;
            "green") echo "$LIGHT_GREEN" ;;
            "teal") echo "$LIGHT_TEAL" ;;
            "purple") echo "$LIGHT_PURPLE" ;;
            "red") echo "$LIGHT_RED" ;;
            "yellow") echo "$LIGHT_YELLOW" ;;
            "orange") echo "$LIGHT_ORANGE" ;;
            "cyan") echo "$LIGHT_CYAN" ;;
        esac
    else
        case $color_name in
            "bg") echo "$DARK_BG" ;;
            "fg") echo "$DARK_FG" ;;
            "surface") echo "$DARK_SURFACE" ;;
            "highlight") echo "$DARK_HIGHLIGHT" ;;
            "gray") echo "$DARK_GRAY" ;;
            "black") echo "$DARK_BLACK" ;;
            "blue") echo "$DARK_BLUE" ;;
            "green") echo "$DARK_GREEN" ;;
            "teal") echo "$DARK_TEAL" ;;
            "purple") echo "$DARK_PURPLE" ;;
            "red") echo "$DARK_RED" ;;
            "yellow") echo "$DARK_YELLOW" ;;
            "orange") echo "$DARK_ORANGE" ;;
            "cyan") echo "$DARK_CYAN" ;;
        esac
    fi
}

# Export all theme colors as environment variables
export_theme_colors() {
    local theme=${1:-$(get_current_theme)}

    if [ "$theme" = "light" ]; then
        export THEME_BG="$LIGHT_BG"
        export THEME_FG="$LIGHT_FG"
        export THEME_SURFACE="$LIGHT_SURFACE"
        export THEME_HIGHLIGHT="$LIGHT_HIGHLIGHT"
        export THEME_GRAY="$LIGHT_GRAY"
        export THEME_BLACK="$LIGHT_BLACK"
        export THEME_BLUE="$LIGHT_BLUE"
        export THEME_GREEN="$LIGHT_GREEN"
        export THEME_TEAL="$LIGHT_TEAL"
        export THEME_PURPLE="$LIGHT_PURPLE"
        export THEME_RED="$LIGHT_RED"
        export THEME_YELLOW="$LIGHT_YELLOW"
        export THEME_ORANGE="$LIGHT_ORANGE"
        export THEME_CYAN="$LIGHT_CYAN"
    else
        export THEME_BG="$DARK_BG"
        export THEME_FG="$DARK_FG"
        export THEME_SURFACE="$DARK_SURFACE"
        export THEME_HIGHLIGHT="$DARK_HIGHLIGHT"
        export THEME_GRAY="$DARK_GRAY"
        export THEME_BLACK="$DARK_BLACK"
        export THEME_BLUE="$DARK_BLUE"
        export THEME_GREEN="$DARK_GREEN"
        export THEME_TEAL="$DARK_TEAL"
        export THEME_PURPLE="$DARK_PURPLE"
        export THEME_RED="$DARK_RED"
        export THEME_YELLOW="$DARK_YELLOW"
        export THEME_ORANGE="$DARK_ORANGE"
        export THEME_CYAN="$DARK_CYAN"
    fi
}

# Get current theme from state file
get_current_theme() {
    local theme_state_file="$HOME/.dotfiles_theme"
    if [ -f "$theme_state_file" ]; then
        cat "$theme_state_file"
    else
        echo "dark"  # Default to dark
    fi
}

# Set theme state
set_current_theme() {
    local theme=$1
    local theme_state_file="$HOME/.dotfiles_theme"
    echo "$theme" > "$theme_state_file"
}
