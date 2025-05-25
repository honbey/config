###################
# Vim/NeoVim      #
###################
if type nvim &>/dev/null; then
  alias vi='nvim' vim='nvim'
  export EDITOR=nvim
  [[ -d "${HOME}/.local/share/nvim/mason/bin" ]] && add-path "${HOME}/.local/share/nvim/mason/bin"
elif type vim &>/dev/null; then
  alias vi='vim' vim='vim'
  export EDITOR=vim
fi
