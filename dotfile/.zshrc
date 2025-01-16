### Initial zi
# add `source <(curl -sL init.zshell.dev); zzinit` to ~/.zshrc
# then run `exec zsh -il`
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
    OMZL::async_prompt.zsh \
    OMZL::git.zsh \
 atload nocd \
    OMZP::git

### custom config
bindkey -e
# let meta-b work well
WORDCHARS=''

# set some environments
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Homebrew/Linuxbrew
if [[ -d /opt/homebrew || -d /home/linuxbrew ]]; then
    # https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
    export HOMEBREW_INSTALL_FROM_API=1
    export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
    export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"

    if [[ -d /home/linuxbrew ]]; then
        # User environment PATH
        export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    else # macOS
        export PATH="/opt/homebrew/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
        # cURL, mtr
        export PATH="/opt/homebrew/opt/mtr/sbin:/opt/homebrew/opt/curl/bin:$PATH"
        # WezTerm(Terminal from Casks)
        [[ "$TERM_PROGRAM" == "WezTerm" ]] && alias imgcat='wezterm imgcat'
    fi
fi

# Set different config such as prompt for different OS
if [[ "$OSTYPE" == darwin* ]]; then
    # macOS
    PS1="%F{gray} %F{cyan}%c "

    # Java
    export MAC_JAVA_VM="/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home"
    export JAVA_HOME="$MAC_JAVA_VM"

# Judge different distributions
elif grep -Eq "Fedora|CentOS|Redhat|openEuler" /etc/*-release; then
    PS1="%F{gray} %F{cyan}%c "
elif grep -Eq "Debian|Ubuntu" /etc/*-release; then
    PS1="%F{blue} %F{cyan}%c "
elif grep -Eq "Kali" /etc/*-release; then
    PS1="%F{blue} %F{cyan}%c "
else
    PS1="%F{green}✓ %F{cyan}%c "
fi
if [[ "$USER" == "root" ]]; then
    PS1="%F{gray} %F{cyan}%c "
fi
zi wait lucid light-mode for \
  pick'mzt.plugins.zsh' from'gitee' \
    honbey/mzt \
  pick'config.zsh' from'gitee' \
    honbey/start-zsh \
  pick'autopair.zsh' \
    hlissner/zsh-autopair

zi ice atclone'dircolors -b LS_COLORS > clrs.zsh' \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}'
zi light trapd00r/LS_COLORS

zi wait'1' lucid light-mode for \
    voronkovich/gitignore.plugin.zsh \
  has'fzf' \
    Aloxaf/fzf-tab

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

# Custom config for specific machine
if [[ -f $HOME/.custom.zsh ]]; then
	source "$HOME/.custom.zsh"
fi

