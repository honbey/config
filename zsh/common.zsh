export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

bindkey -e

# Aliases
alias ls='ls --color=auto' la='ls -A' ll='ls -Ahl' l.='ls -d .*' l='ls -alF'
alias mv='mv -v'
alias grep='grep --color=auto' diff='diff --color=auto'
alias ..='cd ..' ...='cd ../..'
alias :q='exit' :wq='exit'
alias dl='du -h --max-depth=1'
# Safe rm
alias del="rip -i" trash="rip -i"
alias rm="echo Use 'del', or the full path i.e. '/bin/rm'."
# Git
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gst='git status'
alias glog='git log'
alias gck='git checkout'
alias gb='git branch'
alias gt='git tag'

# History
setopt inc_append_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks 
setopt hist_save_no_dups

# GnuPG
type gpg &>/dev/null && export GPG_TTY="$(tty)"

# Custom bin
[[ -d "${HOME}/.bin" ]] && add-path "${HOME}/.bin"
[[ -d "${HOME}/.local/share/nvim/mason/bin" ]] && add-path "${HOME}/.local/share/nvim/mason/bin"

# Environment
[[ -f "${HOME}/.env" ]] && source "${HOME}/.env"
# Custom config for specific machine
[[ -f "${ZSH_CONFIG}/_custom.zsh" ]] && source "${ZSH_CONFIG}/_custom.zsh"
