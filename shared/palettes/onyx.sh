#!/bin/bash
# Onyx — color.bears palette
# Pillars (exact): Onyx #151311 bg, Desert Sand #EED3BA fg, Mauve Shadow #4B262F highlight.
# Accents bumped for readable contrast while keeping the warm desert family.

export THEME_NAME="onyx"
export THEME_VARIANT="dark"
export THEME_DISPLAY="Onyx"

export THEME_BG="#151311"            # Onyx (exact)
export THEME_FG="#eed3ba"            # Desert Sand (exact)
export THEME_SURFACE="#251e1b"       # Lifted onyx — more separation from bg
export THEME_HIGHLIGHT="#4b262f"     # Mauve Shadow (exact)
export THEME_GRAY="#a08d7d"          # Lighter taupe — readable secondary text
export THEME_BLACK="#0a0908"         # Deeper than bg for ANSI 0
export THEME_BORDER="#3a2e2a"        # Subtle warm separator, more visible

export THEME_BLUE="#9fbde0"          # Brighter dusty blue — functions
export THEME_GREEN="#b8c47c"         # Brighter sage/olive — strings
export THEME_TEAL="#c28a9a"          # Brighter mulberry — types
export THEME_PURPLE="#c28a9a"        # Brighter mulberry — types, constants
export THEME_PINK="#d48a9c"          # Brighter rose mulberry — accent
export THEME_RED="#e87462"           # Brighter terracotta — errors
export THEME_YELLOW="#f0c97d"        # Brighter gold — warnings
export THEME_ORANGE="#eda078"        # Brighter amber — keywords
export THEME_CYAN="#a8c8c2"          # Brighter dusty teal — numbers

# tmux accent overrides — blue feels out of family in the warm desert palette
export THEME_TMUX_ACTIVE="pink"      # Active window index chip
export THEME_TMUX_SESSION="orange"   # Session pill
export THEME_TMUX_PATH="green"       # Path pill
export THEME_TMUX_CMD="yellow"       # Command pill (cyan reads too cool here)
