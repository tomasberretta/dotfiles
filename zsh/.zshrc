# ~/.zshrc

autoload -U compinit
compinit

# Carapace configuration
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
source <(carapace _carapace)

# Completion styling (after carapace)
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Autosuggestions (configure BEFORE sourcing)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(expand-or-complete complete-word)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (must be last of the plugins)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

# Keybindings
bindkey -e

# Arrow keys
bindkey '^[[C' forward-char
bindkey '^[[D' backward-char
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# Control keys
bindkey '^A' beginning-of-line
bindkey '^B' backward-char
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^K' kill-line
bindkey '^U' kill-whole-line
bindkey '^W' backward-kill-word
bindkey '^Y' yank

# Autosuggestion bindings
bindkey '^[[1;5C' forward-word
bindkey '^ ' autosuggest-accept
bindkey '^[l' forward-char

# Explicitly bind Tab to completion (ensures carapace works)
bindkey '^I' complete-word

# ============================================================================
# Environment
# ============================================================================
export EDITOR="nvim"
export VISUAL="nvim"

alias ts='~/start_project.sh'

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

# Source Bitwarden environment helper functions
if [[ -f ~/.config/bitwarden/bw-env.sh ]]; then
    source ~/.config/bitwarden/bw-env.sh
fi

alias bwu='bw_unlock'
alias bws='bw sync'
alias bwl='bw lock'
alias bwenv='load_bitwarden_env'
alias bwst='bw status'

# ============================================================================
# Path Configuration
# ============================================================================
export PATH=~/.npm-global/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Projects/Sandbox/dotfiles/scripts:$PATH"
