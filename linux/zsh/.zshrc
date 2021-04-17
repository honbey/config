# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
# If you need to have openssl@1.1 first in your PATH, run:
#  echo 'export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"' >> ~/.zshrc

# For compilers to find openssl@1.1 you may need to set:
#  export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
#  export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"

##########################################################################################
# My zshrc ###############################################################################

source ~/.zinit/bin/zinit.zsh

# Let Meta-B work well
WORDCHARS=''

# User specific aliases and functions
alias ll='ls -alF' la='ls -A' l='ls -CF' l.='ls -d .*'
alias rm='rm -i' cp='cp -v' mv='mv -v'
alias ..='cd ..' ...='cd ../..'
alias ck='cmake .'
alias vi='vim'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias sysservice='systemctl list-units --type=service'

  # Linux
#alias dl='du -h --max-depth=1'
    # Fast Jump
#alias d='dirs -v'
#alias j='jump_dir_stack(){ cd $(grep -m 1 $1 <(dirs -pl)); };jump_dir_stack'
#alias jj='pushd'

  # MacOSX
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias dl='du -h -d 1'
      # burp suite
#alias burp-suite='/opt/homebrew/opt/openjdk/bin/java -jar /Users/honbey/tools/burp-suite/burpsuite_community_v2021.3.1.jar'

# History file configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# Ignore the same commands
export HISTCONTROL=ignoredups

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

# Fast-syntax-highlighting & autosuggestions
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 blockf \
    zsh-users/zsh-completions

# lib/git.zsh is loaded mostly to stay in touch with the plugin (for the users)
zinit wait lucid for \
    zdharma/zsh-unique-id \
    OMZ::lib/git.zsh \
 atload"unalias grv g" \
    OMZ::plugins/git/git.plugin.zsh

#PS1="%F{green}✓ %F{green}%n%F{cyan}@%F{green}%m %F{green} %F{cyan}%c "
PS1="%F{gray} %F{cyan}%c "
#PS1="%F{magenta} %F{cyan}%c "
#PS1="%F{magenta} %F{cyan}%c "
zinit ice wait lucid atload
zinit ice lucid wait='!0'
zinit light honbey/mzt

# My zshrc ###############################################################################
##########################################################################################
