#!/bin/bash
# =============================================================================
# CENTRALIZED COLOR PALETTE  
# =============================================================================
# Single source of truth for all color definitions used across:
# - Neovim (minimal.nvim dark / oxocarbon light)
# - Ghostty terminal
# - Tmux status bar
# - Starship prompt

# =============================================================================
# DARK THEME (minimal.nvim inspired with enhanced contrast)
# =============================================================================
DARK_BG="#191B20"              # Main background
DARK_FG="#DFE0EA"              # Primary text  
DARK_SURFACE="#272932"         # Surface elements
DARK_HIGHLIGHT="#3A3D4A"       # Highlight background (improved contrast)
DARK_GRAY="#515669"            # Secondary elements
DARK_BLACK="#21252D"           # Darker elements

# Dark accent colors (enhanced for better contrast)
DARK_BLUE="#7EB7E6"            # Blue accent
DARK_GREEN="#94DD8E"           # Green accent
DARK_PINK="#D895C7"            # Pink accent
DARK_PURPLE="#B589D6"          # Purple (distinct from pink)
DARK_RED="#E85A84"             # Red accent
DARK_YELLOW="#F9E154"          # Yellow accent (brighter for labels)
DARK_ORANGE="#FF9574"          # Orange accent (more vibrant)
DARK_CYAN="#89DDFF"            # Cyan (distinct from orange)

# =============================================================================
# LIGHT THEME (refined oxocarbon palette)
# =============================================================================
LIGHT_BG="#f4f4f4"             # Main background (matches ghostty exactly)
LIGHT_FG="#2c2c2c"             # Dark text for good contrast
LIGHT_SURFACE="#f0f0f0"        # Light surface
LIGHT_HIGHLIGHT="#e8f2ff"      # Very light blue highlight  
LIGHT_GRAY="#7a7a7a"           # Medium gray for secondary elements
LIGHT_BLACK="#424242"          # Dark elements

# Light accent colors (softer, more pleasant palette)
LIGHT_BLUE="#4d7bd6"           # Softer blue
LIGHT_GREEN="#52a065"          # Pleasant green
LIGHT_PINK="#d967a3"           # Soft pink
LIGHT_PURPLE="#9575cd"         # Gentle purple
LIGHT_RED="#e57373"            # Softer red
LIGHT_YELLOW="#ffb74d"         # Warm yellow
LIGHT_ORANGE="#ff9574"         # Peachy orange
LIGHT_CYAN="#4db6ac"           # Soft teal

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
            "pink") echo "$LIGHT_PINK" ;;
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
            "pink") echo "$DARK_PINK" ;;
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
        export THEME_PINK="$LIGHT_PINK"
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
        export THEME_PINK="$DARK_PINK"
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
