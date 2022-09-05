### Initial zi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

### completion, autosuggestion and git
zi wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zi creinstall -q .' \
    zsh-users/zsh-completions

zi wait lucid for \
    z-shell/zsh-unique-id \
    OMZL::git.zsh \
 atload nocd \
    OMZP::git

### custom config
export LANG=en_US.UTF-8

# Set different config such as prompt for different OS
if [[ "$OSTYPE" == darwin* ]]; then
    # macOS
    PS1="%F{gray} %F{cyan}%c "

    # Homebrew
    export PATH="/opt/homebrew/bin:$PATH"
    PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

elif [[ "$OSTYPE" == linux* ]]; then
    # Judge different distributions
    if   grep -Eq "Fedora|CentOS|Redhat|openEuler" /etc/*-release; then
        PS1="%F{gray} %F{cyan}%c "
    elif grep -Eq "Debian|Ubuntu" /etc/*-release; then
        PS1="%F{blue} %F{cyan}%c "
    elif grep -Eq "Kali" /etc/*-release; then
        PS1="%F{blue} %F{cyan}%c "
    else
        PS1="%F{green}✓ %F{cyan}%c "
    fi

    alias syss='systemctl list-units --type=service'

    # NVIDIA
    if [[ -d "/usr/local/cuda" ]]; then
        export PATH=$PATH:/usr/local/cuda/bin
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64/
        export CUDA_HOME=/usr/local/cuda
    fi
fi
if [[ "$USER" == "root" ]]; then
    PS1="%F{gray} %F{cyan}%c "
fi
zinit ice lucid wait pick'mzt.plugins.zsh'
zinit light honbey/mzt

zi ice atclone'dircolors -b LS_COLORS > clrs.zsh' \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zi light trapd00r/LS_COLORS

# User specific aliases and functions
alias ls='ls --color=auto' la='ls -A' ll='ls -Ahlrt' l.='ls -d .*' l='ls -alF'
alias rm='rm -i' cp='cp -v' mv='mv -v'
alias grep='grep --color=auto'
alias history='history 1'
alias ..='cd ..' ...='cd ../..'
alias :q='exit' :wq='exit'
alias ck='cmake'
alias c='curl'
alias s='ssh'
alias dl='du -h --max-depth=1'

# History file configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY SHARE_HISTORY HIST_EXPIRE_DUPS_FIRST \
    HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS \
    HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS \
    HIST_VERIFY

###
function ap(){source /opt/data/pyvenv/${1}/bin/activate;}
function be(){base64          <(echo "$1")}
function bd(){base64 --decode <(echo "$1")}

# https://unix.stackexchange.com/a/678894
function ue() {
  LC_ALL=C awk -- '
    BEGIN {
      for (i = 1; i <= 255; i++) hex[sprintf("%c", i)] = sprintf("%%%02X", i)
    }
    function urlencode(s, c, i, r, l) {
      l = length(s)
      for (i = 1; i <= l; i++) {
        c = substr(s, i, 1)
        r = r "" (c ~ /^[-._~0-9a-zA-Z]$/ ? c : hex[c])
      }
      return r
    }
    BEGIN {
      for (i = 1; i < ARGC; i++)
        print urlencode(ARGV[i])
    }' "$@"
}

function ud() {echo -e "${1//\%/\\x}"}

function ts() {
    if [[ "${1}" =~ ^[0-9]{10}$ ]]; then
        date -d "@${1}" '+%Y-%m-%d %H:%M:%S'
    elif [[ "${1}" =~ ^[0-9]{13}$ ]]; then
        date -d "@${1:0:10}" "+%Y-%m-%d %H:%M:%S%.${1:10:13}"
    else
        date -d "${1}" "+%s"
    fi
}

if [[ -f "$HOME/.env" ]]; then
    source "$HOME/.env"
fi

if [[ ! -d "$HOME/.bin" ]]; then
    mkdir "$HOME/.bin"
fi

export PATH="$HOME/.bin:$PATH"

# Emacs
if type emacs > /dev/null 2>&1; then
    function start_emacs(){exec emacsclient -c -a "" "$@"}
    alias killemacs="emacsclient -e '(kill-emacs)'"
    alias emacs='start_emacs'
fi

# NeoVim
if   type nvim > /dev/null 2>&1; then
    alias v='nvim'
    alias vi='nvim'
elif type vim  > /dev/null 2>&1; then
    alias vi='vim'
fi

# Docker / Podman
if type podman > /dev/null 2>&1; then
    alias docker='podman'
fi

# Gnupg
if type gpg > /dev/null 2>&1; then
    export GPG_TTY=$(tty)
fi

# Nginx
if   [[ -f "/usr/local/nginx/sbin/nginx"    ]]; then
    alias ng='/usr/local/nginx/sbin/nginx'
elif [[ -f "/var/data/etc/nginx/sbin/nginx" ]]; then
    alias ng='/var/data/etc/nginx/sbin/nginx'
elif type nginx > /dev/null 2>&1; then
    alias ng='nginx'
fi

# Package Management
if ! type app > /dev/null 2>&1; then
    if [[ "$OSTYPE" =~ "darwin*" && -f /opt/homebrew/bin/brew ]]; then
        ln -s /opt/homebrew/bin/brew /opt/homebrew/bin/app
    elif grep -Eq "Fedora|CentOS|Redhat" /etc/*-release; then
        sudo ln -s $(which yum) ${$(which yum)%/*}/app
    elif grep -Eq "Debian|Ubuntu|Kali" /etc/*-release; then
        sudo ln -s $(which apt) ${$(which apt)%/*}/app
    fi
fi

