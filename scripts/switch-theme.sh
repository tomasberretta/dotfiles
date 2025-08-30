#!/bin/bash
# =============================================================================
# UNIFIED THEME SWITCHER
# =============================================================================
# Single script to switch themes across all applications using centralized palette
# Usage:
#   switch-theme          - Toggle between dark and light
#   switch-theme dark     - Switch to dark theme  
#   switch-theme light    - Switch to light theme

# Get script directory
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Source centralized color palette
source "$DOTFILES_DIR/shared/colors.sh"

# =============================================================================
# THEME GENERATORS
# =============================================================================

# Generate ghostty config from template
generate_ghostty_config() {
    local theme=$1
    local template="$DOTFILES_DIR/shared/templates/ghostty.template"
    local output="$DOTFILES_DIR/ghostty/config"
    
    export_theme_colors "$theme"
    
    # Theme-specific variables
    local theme_name
    if [ "$theme" = "light" ]; then
        theme_name="Light"
    else
        theme_name="Dark"
    fi
    
    # Replace template variables with actual colors
    sed "s/{THEME_NAME}/$theme_name/g; \
         s/{BG}/${THEME_BG#\#}/g; \
         s/{FG}/${THEME_FG#\#}/g; \
         s/{SURFACE}/${THEME_SURFACE#\#}/g; \
         s/{HIGHLIGHT}/${THEME_HIGHLIGHT#\#}/g; \
         s/{GRAY}/${THEME_GRAY#\#}/g; \
         s/{BLACK}/${THEME_BLACK#\#}/g; \
         s/{BLUE}/${THEME_BLUE#\#}/g; \
         s/{GREEN}/${THEME_GREEN#\#}/g; \
         s/{PINK}/${THEME_PINK#\#}/g; \
         s/{PURPLE}/${THEME_PURPLE#\#}/g; \
         s/{RED}/${THEME_RED#\#}/g; \
         s/{YELLOW}/${THEME_YELLOW#\#}/g; \
         s/{ORANGE}/${THEME_ORANGE#\#}/g; \
         s/{CYAN}/${THEME_CYAN#\#}/g" \
        "$template" > "$output"
    
    # Copy to home config if it exists
    if [ -d "$HOME/.config/ghostty" ]; then
        cp "$output" "$HOME/.config/ghostty/config" 2>/dev/null || true
        
        # Reload ghostty using keyboard shortcut (Shift+Cmd+,)
        if command -v osascript &>/dev/null; then
            osascript -e 'tell application "System Events" to tell process "Ghostty" to key code 43 using {shift down, command down}' 2>/dev/null || true
        fi
    fi
}

# Generate tmux config from template  
generate_tmux_config() {
    local theme=$1
    local template="$DOTFILES_DIR/shared/templates/tmux.template"
    local output="$DOTFILES_DIR/tmux/theme.conf"
    
    export_theme_colors "$theme"
    
    # Theme-specific accent colors and variable names
    local theme_name active_color_var path_color_var cmd_color_var
    if [ "$theme" = "light" ]; then
        theme_name="Light"
        active_color_var="blue"      # Blue for light theme
        path_color_var="purple"      # Purple for path
        cmd_color_var="orange"       # Orange for command
    else
        theme_name="Dark"
        active_color_var="pink"      # Pink for dark theme (minimal.nvim style)
        path_color_var="blue"        # Blue for path
        cmd_color_var="red"          # Red for command
    fi
    
    # Replace template variables
    sed "s/{THEME_NAME}/$theme_name/g; \
         s/{BG}/$THEME_BG/g; \
         s/{FG}/$THEME_FG/g; \
         s/{SURFACE}/$THEME_SURFACE/g; \
         s/{HIGHLIGHT}/$THEME_HIGHLIGHT/g; \
         s/{GRAY}/$THEME_GRAY/g; \
         s/{BLACK}/$THEME_BLACK/g; \
         s/{BLUE}/$THEME_BLUE/g; \
         s/{GREEN}/$THEME_GREEN/g; \
         s/{PINK}/$THEME_PINK/g; \
         s/{PURPLE}/$THEME_PURPLE/g; \
         s/{RED}/$THEME_RED/g; \
         s/{YELLOW}/$THEME_YELLOW/g; \
         s/{ORANGE}/$THEME_ORANGE/g; \
         s/{CYAN}/$THEME_CYAN/g; \
         s/{ACTIVE_COLOR_VAR}/$active_color_var/g; \
         s/{PATH_COLOR_VAR}/$path_color_var/g; \
         s/{CMD_COLOR_VAR}/$cmd_color_var/g" \
        "$template" > "$output"
    
    # Copy to home config if it exists
    if [ -d "$HOME/.config/tmux" ]; then
        cp "$output" "$HOME/.config/tmux/theme.conf" 2>/dev/null || true
        
        # Reload tmux if running
        if command -v tmux &>/dev/null && tmux list-sessions &>/dev/null 2>&1; then
            tmux source-file ~/.config/tmux/tmux.conf 2>/dev/null || true
            tmux refresh-client -S 2>/dev/null || true
        fi
    fi
}

# Generate starship config from template
generate_starship_config() {
    local theme=$1
    local template="$DOTFILES_DIR/shared/templates/starship.template"
    local output="$DOTFILES_DIR/starship/starship.toml"
    
    export_theme_colors "$theme"
    
    # Theme-specific variables
    local palette_name
    if [ "$theme" = "light" ]; then
        palette_name="unified_light"
    else
        palette_name="unified_dark"
    fi
    
    # Replace template variables
    sed "s/{PALETTE_NAME}/$palette_name/g; \
         s/{BG}/$THEME_BG/g; \
         s/{FG}/$THEME_FG/g; \
         s/{SURFACE}/$THEME_SURFACE/g; \
         s/{HIGHLIGHT}/$THEME_HIGHLIGHT/g; \
         s/{GRAY}/$THEME_GRAY/g; \
         s/{BLACK}/$THEME_BLACK/g; \
         s/{BLUE}/$THEME_BLUE/g; \
         s/{GREEN}/$THEME_GREEN/g; \
         s/{PINK}/$THEME_PINK/g; \
         s/{PURPLE}/$THEME_PURPLE/g; \
         s/{RED}/$THEME_RED/g; \
         s/{YELLOW}/$THEME_YELLOW/g; \
         s/{ORANGE}/$THEME_ORANGE/g; \
         s/{CYAN}/$THEME_CYAN/g" \
        "$template" > "$output"
    
    # Copy to home config if it exists
    if [ -d "$HOME/.config/starship" ]; then
        cp "$output" "$HOME/.config/starship/starship.toml" 2>/dev/null || true
        
        # Clear starship cache to force reload
        if command -v starship >/dev/null 2>&1; then
            pkill -f starship 2>/dev/null || true
        fi
    fi
}

# Update neovim theme
update_neovim_theme() {
    local theme=$1
    local nvim_theme_file="$DOTFILES_DIR/nvim/lua/custom/current-theme.lua"
    
    # Generate theme file that neovim loads on startup
    if [ "$theme" = "light" ]; then
        cat > "$nvim_theme_file" << 'NVIM_EOF'
-- Auto-generated theme configuration
vim.o.background = "light"
vim.cmd("colorscheme oxocarbon")
NVIM_EOF
    else
        cat > "$nvim_theme_file" << 'NVIM_EOF'
-- Auto-generated theme configuration  
vim.o.background = "dark"
vim.cmd("colorscheme minimal")
NVIM_EOF
    fi
    
    # Update all running Neovim instances
    for server in $(nvim --serverlist 2>/dev/null || true); do
        if [ "$theme" = "light" ]; then
            nvim --server "$server" --remote-send ":set background=light<CR>:colorscheme oxocarbon<CR>" 2>/dev/null || true
        else
            nvim --server "$server" --remote-send ":set background=dark<CR>:colorscheme minimal<CR>" 2>/dev/null || true
        fi
    done
}

# =============================================================================
# MAIN FUNCTION
# =============================================================================

main() {
    local target_theme=$1
    
    # Get current theme if no argument provided (toggle)
    if [ -z "$target_theme" ]; then
        current_theme=$(get_current_theme)
        if [ "$current_theme" = "dark" ]; then
            target_theme="light"
        else
            target_theme="dark" 
        fi
    fi
    
    # Validate theme
    if [ "$target_theme" != "dark" ] && [ "$target_theme" != "light" ]; then
        echo "❌ Error: Invalid theme '$target_theme'. Use 'dark' or 'light'."
        exit 1
    fi
    
    # Show what we're doing
    if [ "$target_theme" = "light" ]; then
        echo "☀️  Switching to light theme..."
    else
        echo "🌙 Switching to dark theme..."
    fi
    
    # Generate all configs from centralized palette
    echo "  🎨 Generating configs from centralized palette..."
    
    # Update all components
    generate_ghostty_config "$target_theme"
    generate_tmux_config "$target_theme" 
    generate_starship_config "$target_theme"
    update_neovim_theme "$target_theme"
    
    # Save theme state (do this last)
    set_current_theme "$target_theme"
    
    echo ""
    echo "✨ Theme switched to: $target_theme"
    echo ""
    echo "🔄 Updated configurations:"
    echo "  ✓ Ghostty terminal (${target_theme} colors)"
    echo "  ✓ Tmux status bar (${target_theme} colors)"  
    echo "  ✓ Starship prompt (${target_theme} colors)"
    echo "  ✓ Neovim editor (${target_theme} colors)"
    echo ""
    echo "💡 All apps now use the same centralized color palette!"
}

# Execute main function
main "$@"
