# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Home Bin
export PATH="$PATH:/$HOME/.local/bin"

# Starship Config
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# EDITOR
export EDITOR=nvim
export VISUAL=nvim

# Aliases
alias grep='grep --color=auto'
alias la='eza --icons -la'
alias tmac="tmux new -A -s"

# INIT
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
