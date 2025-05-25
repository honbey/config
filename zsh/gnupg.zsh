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
