# PNPM
if type pnpm &>/dev/null; then
  export PNPM_HOME="/opt/data/pnpm"
  add-path "$PNPM_HOME"
  alias npm='pnpm'
fi

