#!/bin/bash
# =============================================================================
# UNIFIED THEME SWITCHER
# =============================================================================
# Switch color palettes across ghostty, tmux, starship, nvim, and fish.
#
# Usage:
#   switch-theme                   Cycle to next palette
#   switch-theme <name>            Switch to a specific palette (e.g. onyx)
#   switch-theme list              List available palettes
#   switch-theme dark | light      Back-compat: aliases for intellij-dark/light
#
# Add palettes by dropping a file in shared/palettes/<name>.sh that exports
# the THEME_* variable set. The switcher picks them up automatically.

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
export DOTFILES_DIR

# shellcheck source=../shared/colors.sh
source "$DOTFILES_DIR/shared/colors.sh"

# =============================================================================
# TEMPLATE RENDERING
# =============================================================================

# Render a template file by substituting every {TOKEN} the palette defines.
# Uses a pipeline of seds so we don't care about the template's ordering.
render_template() {
    local template=$1
    local output=$2
    local stripped=${3:-no}   # "yes" to drop leading '#' from color values (ghostty)

    local bg=$THEME_BG fg=$THEME_FG surface=$THEME_SURFACE highlight=$THEME_HIGHLIGHT
    local gray=$THEME_GRAY black=$THEME_BLACK border=$THEME_BORDER
    local blue=$THEME_BLUE green=$THEME_GREEN teal=$THEME_TEAL purple=$THEME_PURPLE
    local pink=$THEME_PINK red=$THEME_RED yellow=$THEME_YELLOW orange=$THEME_ORANGE
    local cyan=$THEME_CYAN

    if [ "$stripped" = "yes" ]; then
        bg=${bg#\#}; fg=${fg#\#}; surface=${surface#\#}; highlight=${highlight#\#}
        gray=${gray#\#}; black=${black#\#}; border=${border#\#}
        blue=${blue#\#}; green=${green#\#}; teal=${teal#\#}; purple=${purple#\#}
        pink=${pink#\#}; red=${red#\#}; yellow=${yellow#\#}; orange=${orange#\#}
        cyan=${cyan#\#}
    fi

    sed \
        -e "s|{THEME_NAME}|${THEME_DISPLAY:-$THEME_NAME}|g" \
        -e "s|{PALETTE_NAME}|${THEME_NAME}|g" \
        -e "s|{VARIANT}|${THEME_VARIANT}|g" \
        -e "s|{BG}|$bg|g" \
        -e "s|{FG}|$fg|g" \
        -e "s|{SURFACE}|$surface|g" \
        -e "s|{HIGHLIGHT}|$highlight|g" \
        -e "s|{GRAY}|$gray|g" \
        -e "s|{BLACK}|$black|g" \
        -e "s|{BORDER}|$border|g" \
        -e "s|{BLUE}|$blue|g" \
        -e "s|{GREEN}|$green|g" \
        -e "s|{TEAL}|$teal|g" \
        -e "s|{PURPLE}|$purple|g" \
        -e "s|{PINK}|$pink|g" \
        -e "s|{RED}|$red|g" \
        -e "s|{YELLOW}|$yellow|g" \
        -e "s|{ORANGE}|$orange|g" \
        -e "s|{CYAN}|$cyan|g" \
        "$template" > "$output"
}

# =============================================================================
# PER-APP GENERATORS
# =============================================================================

# Variant-specific tmux accent slots. A palette can override these by exporting
# THEME_TMUX_ACTIVE / THEME_TMUX_PATH / THEME_TMUX_CMD in its palette file.
tmux_accents() {
    TMUX_ACTIVE=${THEME_TMUX_ACTIVE:-blue}
    TMUX_SESSION=${THEME_TMUX_SESSION:-orange}
    TMUX_PATH=${THEME_TMUX_PATH:-green}
    TMUX_CMD=${THEME_TMUX_CMD:-cyan}
}

generate_ghostty_config() {
    local out="$DOTFILES_DIR/ghostty/config"
    render_template "$DOTFILES_DIR/shared/templates/ghostty.template" "$out" yes

    if [ -d "$HOME/.config/ghostty" ]; then
        cp "$out" "$HOME/.config/ghostty/config" 2>/dev/null || true
        if command -v osascript &>/dev/null; then
            osascript -e 'tell application "System Events" to tell process "Ghostty" to key code 43 using {shift down, command down}' 2>/dev/null || true
        fi
    fi
}

generate_tmux_config() {
    local out="$DOTFILES_DIR/tmux/theme.conf"
    tmux_accents
    render_template "$DOTFILES_DIR/shared/templates/tmux.template" "$out"

    # Fill in the tmux-specific accent tokens (kept outside render_template
    # because they reference color *names*, not hex values).
    sed -i '' \
        -e "s|{ACTIVE_COLOR_VAR}|$TMUX_ACTIVE|g" \
        -e "s|{SESSION_COLOR_VAR}|$TMUX_SESSION|g" \
        -e "s|{PATH_COLOR_VAR}|$TMUX_PATH|g" \
        -e "s|{CMD_COLOR_VAR}|$TMUX_CMD|g" \
        "$out"

    if [ -d "$HOME/.config/tmux" ]; then
        cp "$out" "$HOME/.config/tmux/theme.conf" 2>/dev/null || true
        if command -v tmux &>/dev/null && tmux list-sessions &>/dev/null 2>&1; then
            tmux source-file ~/.config/tmux/tmux.conf 2>/dev/null || true
            tmux refresh-client -S 2>/dev/null || true
        fi
    fi
}

generate_starship_config() {
    local out="$DOTFILES_DIR/starship/starship.toml"
    render_template "$DOTFILES_DIR/shared/templates/starship.template" "$out"

    if [ -d "$HOME/.config/starship" ]; then
        cp "$out" "$HOME/.config/starship/starship.toml" 2>/dev/null || true
        if command -v starship >/dev/null 2>&1; then
            pkill -f starship 2>/dev/null || true
        fi
    fi
}

generate_fish_colors() {
    local out="$DOTFILES_DIR/fish/colors.fish"
    render_template "$DOTFILES_DIR/shared/templates/fish.template" "$out" yes

    if [ -d "$HOME/.config/fish" ]; then
        cp "$out" "$HOME/.config/fish/colors.fish" 2>/dev/null || true
    fi
}

# Write a small lua snippet that nvim loads on startup to know which palette
# is active. theme.lua itself holds the full palette definitions.
update_neovim_theme() {
    local nvim_theme_file="$DOTFILES_DIR/nvim/lua/custom/current-theme.lua"
    cat > "$nvim_theme_file" <<LUA
-- Auto-generated by scripts/switch-theme.sh. Do not edit by hand.
return {
  name = "${THEME_NAME}",
  variant = "${THEME_VARIANT}",
}
LUA

    # Also drop it into the live config dir if nvim is symlinked there.
    if [ -d "$HOME/.config/nvim/lua/custom" ]; then
        cp "$nvim_theme_file" "$HOME/.config/nvim/lua/custom/current-theme.lua" 2>/dev/null || true
    fi

    # Hot-reload any running nvim instances via their listen sockets.
    for server in $(nvim --serverlist 2>/dev/null || true); do
        nvim --server "$server" --remote-send ":lua require('custom.theme').reload()<CR>" 2>/dev/null || true
    done
}

# =============================================================================
# MAIN
# =============================================================================

cycle_next_palette() {
    local current; current=$(get_current_palette)
    local palettes; palettes=$(list_palettes)
    local first=""
    local take_next=0
    while IFS= read -r p; do
        [ -z "$p" ] && continue
        [ -z "$first" ] && first="$p"
        if [ $take_next -eq 1 ]; then
            echo "$p"; return
        fi
        [ "$p" = "$current" ] && take_next=1
    done <<< "$palettes"
    # Wrap around to the first palette.
    echo "$first"
}

print_help() {
    echo "Usage: switch-theme [list|<palette>|dark|light]"
    echo ""
    echo "Available palettes:"
    while IFS= read -r p; do
        [ -z "$p" ] && continue
        (load_palette "$p" >/dev/null 2>&1 && printf "  %-18s  %s\n" "$p" "${THEME_DISPLAY:-$p} (${THEME_VARIANT})")
    done <<< "$(list_palettes)"
}

main() {
    local target=${1:-}

    case "$target" in
        ""|next) target=$(cycle_next_palette) ;;
        list|ls|-l|--list) print_help; return 0 ;;
        -h|--help|help) print_help; return 0 ;;
        dark)  target="intellij-dark" ;;
        light) target="intellij-light" ;;
    esac

    if ! load_palette "$target"; then
        return 1
    fi

    echo "🎨 Switching to palette: ${THEME_DISPLAY:-$target} (${THEME_VARIANT})"

    generate_ghostty_config
    generate_tmux_config
    generate_starship_config
    generate_fish_colors
    update_neovim_theme

    set_current_palette "$THEME_NAME"

    echo ""
    echo "✨ Applied ${THEME_NAME}:"
    echo "  ✓ Ghostty, Tmux, Starship, Fish, Neovim"
    echo ""
    echo "💡 Run 'switch-theme list' to see all palettes."
}

main "$@"
