###################
# Python          #
###################
# Acticate Python virtual environments.
#   $1 string: name of venv
#   $2 string: path of venv
#   *return null
function ap() {
  if [[ -z $1 ]]; then
    if [[ -d ./venv ]]; then
      source "./venv/bin/activate"
    elif [[ -d ./.venv ]]; then
      source "./.venv/bin/activate"
    else
      echo "No virtual env!"
    fi
    return
  fi
  if [[ -z $2 ]]; then
    PYVENV_PATH="${DATA_DIR}/pyvenv"
  else
    PYVENV_PATH=$2
  fi
  source "${PYVENV_PATH}/$1/bin/activate"
}

_ap() {
  local -a venvs
  local venvs=($(find /opt/data/pyvenv -mindepth 1 -maxdepth 1 -type d |
    awk -v FS='/' '{printf "%s\n", $NF}'))
  _describe 'virtual environments' venvs
}

compdef _ap ap

# pip
alias pip='pip3'
alias pip-ali='pip3 -i https://mirrors.aliyun.com/pypi/simple'
alias pip-ustc='pip3 -i https://mirrors.ustc.edu.cn/pypi/simple'
alias pip-tsinghua='pip3 -i https://pypi.tuna.tsinghua.edu.cn/simple'

###################
# Rust            #
###################
if type rustc &>/dev/null; then
  export RUSTPATH="${DATA_DIR}/rust"
  export CARGO_HOME="${RUSTPATH}/cargo"
  export RUST_HOME="${RUSTPATH}/rustup"
  add-path "${CARGO_HOME}/bin"
fi

###################
# Golang          #
###################
if type go &>/dev/null; then
  export GOPATH="${DATA_DIR}/go"
  add-path "${GOPATH}/bin"
fi
