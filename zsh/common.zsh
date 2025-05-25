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
alias del="rip -i --graveyard /opt/data/graveyard" trash="rip -i --graveyard /opt/data/graveyard"
alias rm="echo Use 'del', or the full path i.e. '/bin/rm'."

# History
setopt inc_append_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_save_no_dups

###################
# Homebrew        #
###################
# homebrew / linuxbrew
if [[ -d /opt/homebrew || -d /home/linuxbrew ]]; then
  export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
  #export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
  export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"

  if [[ -d /home/linuxbrew ]]; then # linux
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else # macOS, make sure you have installed coreutils, mtr, gnu-sed, curl
    add-path "/opt/homebrew/opt/coreutils/libexec/gnubin"
    add-path "/opt/homebrew/opt/mtr/sbin"
    add-path "/opt/homebrew/opt/gnu-sed/bin"
    add-path "/opt/homebrew/opt/curl/bin"

    zinit add-fpath "/opt/homebrew/share/zsh/site-functions"

    # TODO: MANPATH
  fi
fi

# To change the mirror of Homebrew to escalate download speed.
# Because the Tsinghua mirror can not be accessed in some public WiFi.
# The HOMEBREW_BREW_GIT_REMOTE's PATH is different in different mirror.
#   $1 string  mirror's name ['ustc', 'ali']
#   *return null
function change-brew-mirror() {
  local MIRROR_URL
  if [[ "$1" == "ustc" ]]; then
    MIRROR_URL='https://mirrors.ustc.edu.cn'
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
    #export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
  elif [[ "$1" == "ali" ]]; then
    MIRROR_URL='https://mirrors.aliyun.com'
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
    #export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"
  else
    echo "Please provide mirror name, only support $(ustc) or $(ali) now."
  fi
  export HOMEBREW_API_DOMAIN="${MIRROR_URL}/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="${MIRROR_URL}/homebrew-bottles"
  export HOMEBREW_PIP_INDEX_URL="${MIRROR_URL}/pypi/simple"
}

###################
# GnuPG           #
###################
if type gpg &>/dev/null; then

  # GPG-Agent
  # https://bbs.archlinux.org/viewtopic.php?id=224973
  if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
  fi

  # Set SSH to use gpg-agent
  unset SSH_AGENT_PID
  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  fi
  # gpgconf --launch gpg-agent

  export GPG_TTY="$(tty)"

  # Refresh gpg-agent tty in case user switches into an X session
  gpg-connect-agent updatestartuptty /bye >/dev/null

  # aliases
  alias gnupg='gpg'

  [[ -d "${HOME}/.gnupg" ]] || mkdir ${HOME}/.gnupg

  # https://github.com/NeogitOrg/neogit/blob/master/doc/neogit.txt#L323
  if ! [[ -f "${HOME}/.gnupg/gpg.conf" ]]; then
    echo -e 'pinentry-mode loopback' >"${HOME}/.gnupg/gpg.conf"
  fi
  if ! [[ -f "${HOME}/.gnupg/gpg-agent.conf" ]]; then
    if [[ -d /opt/homebrew ]]; then
      echo -e "enable-ssh-support\npinentry-program /opt/homebrew/bin/pinentry-tty\nallow-loopback-pinentry" \
        >"${HOME}/.gnupg/gpg-agent.conf"
    elif [[ -d /home/linuxbrew ]]; then
      echo -e "enable-ssh-support\npinentry-program /home/linuxbrew/.linuxbrew/bin/pinentry-tty\nallow-loopback-pinentry" \
        >"${HOME}/.gnupg/gpg-agent.conf"
    fi
  fi
fi

###################
# Git             #
###################
# aliases
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gc='git commit --amend'
alias gcs='git commit -S'
alias gcsa='git commit -S --amend'
alias gp='git push'
alias gl='git pull'
alias gpm='git push origin main'
alias glm='git pull origin main'
alias gst='git status'
alias glog='git log'
alias glogc='git logc'
alias gck='git checkout'
alias gb='git branch'
alias gt='git tag'

### Custom ###
[[ -d "${HOME}/.bin" ]] && add-path "${HOME}/.bin"
# Environment
[[ -f "${HOME}/.env" ]] && source "${HOME}/.env"
# Custom config for specific machine
[[ -f "${ZSH_CONFIG}/_custom.zsh" ]] && source "${ZSH_CONFIG}/_custom.zsh"
