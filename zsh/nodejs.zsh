# PNPM
if type pnpm &>/dev/null; then
  export PNPM_HOME="/opt/data/pnpm"
  export PATH="$PNPM_HOME:$PATH"
  alias npm='pnpm'
fi

