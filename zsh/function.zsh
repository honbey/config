# like fish's `add_user_path`
function add-path() {
  local new_path="$1"

  if [[ ":$PATH:" == *":$new_path:"* ]]; then
    return 0
  fi

  if [[ "$2" == "tail" ]]; then
    export PATH="$PATH:$new_path"
    return 0
  else
    export PATH="$new_path:$PATH"
    return 0
  fi
}

# Base64 encode/decode
function b64e() {
  base64 <(echo "$1")
}
function b64d() {
  base64 --decode <(echo "$1")
}

# URL encode/decode
# https://unix.stackexchange.com/a/678894
function urle() {
  LC_ALL=C awk -- '
    BEGIN {
      for (i = 1; i <= 255; i++) hex[sprintf("%c", i)] = sprintf("%%%02X", i)
    }
    function urlencode(s, c, i, r, l) {
      l = length(s)
      for (i = 1; i <= l; i++) {
        c = substr(s, i, 1)
        r = r "" (c ~ /^[-._~0-9a-zA-Z]$/ ? c : hex[c])
      }
      return r
    }
    BEGIN {
      for (i = 1; i < ARGC; i++)
        print urlencode(ARGV[i])
    }' "$@"
}
function urld() { echo -e "${1//\%/\\x}" }

# Timestamp to datetime or inversely
function ts() {
  if [[ "${1}" =~ ^[0-9]{10}$ ]]; then
    date -d "@${1}" '+%Y-%m-%d %H:%M:%S'
  elif [[ "${1}" =~ ^[0-9]{13}$ ]]; then
    date -d "@${1:0:10}" "+%Y-%m-%d %H:%M:%S%.${1:10:13}"
  else
    date -d "${1}" "+%s"
  fi
}

# Proxy
function set-proxy() {
  export ALL_PROXY="${1:-http}://${2:-127.0.0.1}:${3:-1080}"
  export HTTP_PROXY=${ALL_PROXY}
  export HTTPS_PROXY=${ALL_PROXY}
}
function unset-proxy() {
  unset ALL_PROXY HTTP_PROXY HTTPS_PROXY
}

# rsync -> cp / scp (Like OMZ's cpv)
function cp() {
  rsync -ahv --backup-dir="/tmp/rsync-${USERNAME}" --progress "$@"
}
compdef _files cp
function scp() {
  rsync -ahv -z --progress "$@"
}
compdef _files scp

# Better $PATH
function show-path() {
  echo ${PATH//:/\\n}
}
function show-fpath() {
  echo ${FPATH//:/\\n}
}

# Because the network problem of GitHub, I choose to update
# the snippets that are local.
#   *return null
function update-local-snippets() {
  if [[ -z ${ZSH_CONFIG} ]]; then
    ZSH_CONFIG="${HOME}/.config/zsh"
  fi
  local ZI_SNIPPETS_PATH
  ZI_SNIPPETS_PATH=${ZSH_CONFIG#/}
  ZI_SNIPPETS_PATH=${ZI_SNIPPETS_PATH//\//--}
  for i in $(ls ${HOME}/.config/zsh/[^_]*); do
    local BASE_NAME="$(basename ${i})"
    if [[ $(basename ${i}) != 'zshrc' ]]; then
      zinit update "${ZI_SNIPPETS_PATH}/${BASE_NAME}"
    fi
  done
}

# Transale English word to Chinese
# I find a wonderful dictionary from [skywind3000](https://skywind.me/).
# The author's recommand way to use is use [GoldenDict](https://github.com/goldendict/goldendict)
# But it has no official universal releases for macOS, I choose to use sqlite3 at present.
# Dictionary from https://github.com/skywind3000/ECDICT-ultimate/releases/tag/1.0.0
#    $1 word
#    * return null
function t() {
  # TODO: use python to beautify output
  sqlite3 \
    /opt/data/resources/EC-DICT-Ultimate.db \
    "select word,phonetic,definition,exchange,translation from stardict where word like '${1:-China}'"
}

# Provide the ability to change the current working directory when exiting Yazi.
#    * return null
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
