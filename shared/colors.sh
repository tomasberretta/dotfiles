#!/bin/bash
# =============================================================================
# CENTRALIZED PALETTE DISPATCHER
# =============================================================================
# Single source of truth for color palettes across:
#   Neovim · Ghostty · Tmux · Starship · Fish
#
# Palettes live in shared/palettes/<name>.sh and export THEME_* variables.
# Add a new palette by dropping a new file in that directory — no code changes.

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
PALETTE_DIR="$DOTFILES_DIR/shared/palettes"
THEME_STATE_FILE="$HOME/.dotfiles_theme"
DEFAULT_PALETTE="intellij-dark"

# List all available palette names (basenames without .sh), sorted.
list_palettes() {
    if [ -d "$PALETTE_DIR" ]; then
        for f in "$PALETTE_DIR"/*.sh; do
            [ -f "$f" ] || continue
            basename "$f" .sh
        done | sort
    fi
}

# Print the current palette name from state, or default if unset/invalid.
get_current_palette() {
    local name=""
    if [ -f "$THEME_STATE_FILE" ]; then
        name=$(cat "$THEME_STATE_FILE" 2>/dev/null | tr -d '[:space:]')
    fi

    # Back-compat: old state files stored "dark" / "light".
    case "$name" in
        dark)  name="intellij-dark" ;;
        light) name="intellij-light" ;;
    esac

    # Validate — fall back to default if the stored palette no longer exists.
    if [ -n "$name" ] && [ -f "$PALETTE_DIR/$name.sh" ]; then
        echo "$name"
    else
        echo "$DEFAULT_PALETTE"
    fi
}

# Persist the active palette name.
set_current_palette() {
    echo "$1" > "$THEME_STATE_FILE"
}

# Source a palette's THEME_* exports into the current shell.
# Usage: load_palette [name]  (defaults to current palette)
load_palette() {
    local name=${1:-$(get_current_palette)}
    local file="$PALETTE_DIR/$name.sh"
    if [ ! -f "$file" ]; then
        echo "❌ Palette not found: $name" >&2
        echo "Available: $(list_palettes | tr '\n' ' ')" >&2
        return 1
    fi
    # shellcheck disable=SC1090
    source "$file"
}

# Back-compat shim: old scripts called `export_theme_colors dark|light`.
export_theme_colors() {
    local arg=$1
    case "$arg" in
        dark)  load_palette "intellij-dark" ;;
        light) load_palette "intellij-light" ;;
        "")    load_palette ;;
        *)     load_palette "$arg" ;;
    esac
}

# Back-compat shims for scripts still thinking in dark/light terms.
get_current_theme() {
    load_palette >/dev/null 2>&1
    echo "${THEME_VARIANT:-dark}"
}

set_current_theme() {
    # Map legacy dark/light calls to the corresponding intellij palette;
    # otherwise treat the arg as a palette name.
    case "$1" in
        dark)  set_current_palette "intellij-dark" ;;
        light) set_current_palette "intellij-light" ;;
        *)     set_current_palette "$1" ;;
    esac
}

# Look up a single color from the active (or specified) palette.
# Usage: get_color bg [palette]
get_color() {
    local key=$1
    local name=${2:-$(get_current_palette)}
    (
        load_palette "$name" || return 1
        case "$key" in
            bg)        echo "$THEME_BG" ;;
            fg)        echo "$THEME_FG" ;;
            surface)   echo "$THEME_SURFACE" ;;
            highlight) echo "$THEME_HIGHLIGHT" ;;
            gray)      echo "$THEME_GRAY" ;;
            black)     echo "$THEME_BLACK" ;;
            border)    echo "$THEME_BORDER" ;;
            blue)      echo "$THEME_BLUE" ;;
            green)     echo "$THEME_GREEN" ;;
            teal)      echo "$THEME_TEAL" ;;
            purple)    echo "$THEME_PURPLE" ;;
            pink)      echo "$THEME_PINK" ;;
            red)       echo "$THEME_RED" ;;
            yellow)    echo "$THEME_YELLOW" ;;
            orange)    echo "$THEME_ORANGE" ;;
            cyan)      echo "$THEME_CYAN" ;;
            variant)   echo "$THEME_VARIANT" ;;
            display)   echo "$THEME_DISPLAY" ;;
            *)         echo "" ;;
        esac
    )
}
