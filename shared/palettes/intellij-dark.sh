#!/bin/bash
# IntelliJ New UI Dark
# Exports THEME_* variables. Sourced by shared/colors.sh.

export THEME_NAME="intellij-dark"
export THEME_VARIANT="dark"          # dark | light — used by nvim to set vim.o.background
export THEME_DISPLAY="IntelliJ Dark"

export THEME_BG="#1e1f22"            # Main background
export THEME_FG="#bcbec4"            # Primary text
export THEME_SURFACE="#2b2d30"       # Panels, toolbars, floats
export THEME_HIGHLIGHT="#214283"     # Visual/selection highlight
export THEME_GRAY="#6f737a"          # Comments, line numbers
export THEME_BLACK="#1e1f22"         # Darker ANSI 0
export THEME_BORDER="#393b40"        # Borders, separators

export THEME_BLUE="#56a8f5"          # Functions, links
export THEME_GREEN="#6aab73"         # Strings, success
export THEME_TEAL="#c77dbb"          # Types (IJ convention, same as purple)
export THEME_PURPLE="#c77dbb"        # Types, constants
export THEME_PINK="#c77dbb"          # tmux/starship pink slot
export THEME_RED="#f75464"           # Errors, deletions
export THEME_YELLOW="#f2c55c"        # Warnings, search highlights
export THEME_ORANGE="#cf8e6d"        # Keywords
export THEME_CYAN="#2aacb8"          # Numbers, special values
