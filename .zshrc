# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# GPG
export GPG_TTY=$(tty)

# Home Bin
export PATH="/$HOME/.local/bin:$PATH"

# Brew path
export PATH="/opt/homebrew/sbin:$PATH"

# Starship Config
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# EDITOR
export EDITOR=nvim
export VISUAL=nvim

# Aliases
alias grep='grep --color=auto'
alias la='eza --icons -la'
alias ta="tmux new -A"

# Keybinds
() {
 emulate -L zsh
 autoload -Uz history-search-end
 local widget keyseq
 for widget ( back for )  zle -N history-beginning-search-${widget}ward-end history-search-end
 for keyseq ( '^[OA' '^[[A' )  bindkey $keyseq history-beginning-search-backward-end  # up
 for keyseq ( '^[OB' '^[[B' )  bindkey $keyseq history-beginning-search-forward-end   # down
}

# INIT
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select
eval "$(ewiz init zsh)"
