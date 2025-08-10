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

# INIT
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval 'eval "$(mise activate bash)"'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
