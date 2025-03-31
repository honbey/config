export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Aliases
alias ls='ls --color=auto' la='ls -A' ll='ls -Ahl' l.='ls -d .*' l='ls -alF'
alias rm='rm -i' cp='cp -v' mv='mv -v'
alias grep='grep --color=auto' diff='diff --color=auto'
alias ..='cd ..' ...='cd ../..'
alias :q='exit' :wq='exit'
alias dl='du -h --max-depth=1'

# History
setopt inc_append_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks 
setopt hist_save_no_dups

# GnuPG
type gpg &>/dev/null && export GPG_TTY="$(tty)"

# Custom bin
[[ -d "$HOME/.bin" ]] && add-path "$HOME/.bin"
[[ -d "$HOME/.local/share/nvim/mason/bin" ]] && add-path "$HOME/.local/share/nvim/mason/bin"

# Environment
[[ -f "$HOME/.env" ]] && source "$HOME/.env"
# Custom config for specific machine
[[ -f "$HOME/.custom.zsh" ]] && source "$HOME/.custom.zsh"
