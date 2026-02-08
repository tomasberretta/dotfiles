# Fish Shell Configuration

# Suppress greeting
set -g fish_greeting

if status is-interactive
    # Homebrew
    eval (/opt/homebrew/bin/brew shellenv)

    # Initialize Starship prompt
    starship init fish | source

    # Zoxide
    zoxide init fish | source

    # Aliases
    alias ts='~/Projects/Sandbox/dotfiles/scripts/start_project.sh'
end
