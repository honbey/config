# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias dl='du -h --max-depth=1'
alias rm='rm -i'
alias ck='cmake .'
alias ..='cd ..'

  # WSL
alias open='explorer.exe'

  # X Display
export DISPLAY=:0
  # WSL 2
    # X Display, should get the host ip by '/etc/resolv.conf'
#host=$(cat /etc/resolv.conf | sed -n 's/^nameserver\W\(.*\)$/\1/p' | head -n 1)
#export DISPLAY=${host}:0
