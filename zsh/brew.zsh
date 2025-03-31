# Homebrew
if [[ -d /opt/homebrew || -d /home/linuxbrew ]]; then
  export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
  #export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
  export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"

  if [[ -d /home/linuxbrew ]]; then # linux
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else # macOS, make sure you have installed coreutils, mtr, gnu-sed, curl
    add-path "/opt/homebrew/opt/coreutils/libexec/gnubin"
    add-path "/opt/homebrew/opt/mtr/sbin"
    add-path "/opt/homebrew/opt/gnu-sed/bin"
    add-path "/opt/homebrew/opt/curl/bin"

    zinit add-fpath "/opt/homebrew/share/zsh/site-functions"

    # TODO: MANPATH
  fi
fi

function change-brew-mirror() {
  if [[ "$1" == "ustc" ]]; then
    export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
    #export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
    export HOMEBREW_PIP_INDEX_URL="https://mirrors.ustc.edu.cn/pypi/simple"
  elif [[ "$1" == "ali" ]]; then
    export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles/api"
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
    #export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"
    export HOMEBREW_PIP_INDEX_URL="https://mirrors.aliyun.com/pypi/simple"
  else
    echo "Please provide mirror name, only support `ustc` or `ali` now."
  fi
}
