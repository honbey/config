# Python
# acticate Python venv
#   $1 string  name of venv
#   $2 string  path of venv
#   *return null
function ap() {
  if [[ -z ${1} ]]; then
    return
  fi
  if [[ -z ${2} ]]; then
    PYVENV_PATH="/opt/data/pyvenv/"
  else
    PYVENV_PATH=${2}
  fi
  source "${PYVENV_PATH}/${1}/bin/activate"
}

# pip
alias pip='pip3'
alias pip-ali='pip3 -i https://mirrors.aliyun.com/pypi/simple'
alias pip-ustc='pip3 -i https://mirrors.ustc.edu.cn/pypi/simple'
alias pip-tsinghua='pip3 -i https://pypi.tuna.tsinghua.edu.cn/simple'
