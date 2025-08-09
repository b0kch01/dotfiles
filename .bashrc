# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# INIT
eval "$(zoxide init bash)"
eval 'eval "$(mise activate bash)"'

# Home Bin
export PATH="$PATH:/$HOME/.local/bin"

# EDITOR
export EDITOR=nvim
export VISUAL=nvim

# Aliases
alias grep='grep --color=auto'
alias la='eza --icons -la'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
