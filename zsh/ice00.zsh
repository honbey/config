# Beautify the output of PATH and FPATH.
#   *return null
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
    local BASE_NAME="$(basename $i)"
    if [[ $(basename $i) != 'zshrc' ]]; then
      zinit update "${ZI_SNIPPETS_PATH}/${BASE_NAME}"
    fi
  done
}

# Perform Base64 encoding and decoding on a string.
#   $@ string
#   *return string
function b64e() {
  base64 <(echo "$@")
}
function b64d() {
  base64 --decode <(echo "$@")
}

# Perform URL encoding and decoding on a string.
# Reference:
# - https://unix.stackexchange.com/a/678894
#   $@ string
#   *return string
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
function urld() {
  echo -e "${@//\%/\\x}"
}

# Timestamp to datetime or inversely.
#   $@ int or string
#   *return string or int
function ts() {
  if [[ "$1" =~ ^[0-9]{10}$ ]]; then
    date -d "@$1" '+%Y-%m-%d %H:%M:%S'
  elif [[ "$1" =~ ^[0-9]{13}$ ]]; then
    date -d "@${1:0:10}" "+%Y-%m-%d %H:%M:%S%.${1:10:13}"
  else
    date -d "$1" "+%s"
  fi
}

# Set or unset proxy environment.
#   $1 string: proxy protocol, default http
#   $2 string: proxy address, default 127.0.0.1
#   $3 int: proxy port, default 1080
#   *return null
function set-proxy() {
  export ALL_PROXY="${1:-http}://${2:-127.0.0.1}:${3:-1080}"
  export HTTP_PROXY="${ALL_PROXY}"
  export HTTPS_PROXY="${ALL_PROXY}"
}
function unset-proxy() {
  unset ALL_PROXY HTTP_PROXY HTTPS_PROXY
}

# Use rsync to implement cp and scp, like OMZ's cpv.
#   $@ string: file or directory
#   *return null
function cp() {
  rsync -ahv --backup-dir="/tmp/rsync-${USERNAME}" --progress "$@"
}
compdef _files cp
function scp() {
  rsync -ahv -z --progress "$@"
}
compdef _files scp

# Transale English word to Chinese.
# I find a wonderful dictionary from [skywind3000](https://skywind.me/).
# The author's recommand way to use is use [GoldenDict](https://github.com/goldendict/goldendict)
# But it has no official universal releases for macOS, I choose to use sqlite3 at present.
# Dictionary from https://github.com/skywind3000/ECDICT-ultimate/releases/tag/1.0.0
#   $1 string: English word, default China
#   *return string
function t() {
  if [[ -f "${WORKSPACE}/script/python/query_english_word_from_dict.py" ]]; then
    "${DATA_DIR}/pyvenv/work/bin/python" \
      "${WORKSPACE}/script/python/query_english_word_from_dict.py" \
      "${1:-China}" -d "${RESOURCES}/EC-DICT-Ultimate.db"
  else
    sqlite3 \
      "${RESOURCES}/EC-DICT-Ultimate.db" \
      "select word,phonetic,definition,exchange,translation from stardict where word like '${1:-China}'"
  fi
}

# Provide the ability to change the current working directory when exiting Yazi.
#    * return null
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="${tmp}"
  IFS= read -r -d '' cwd <"${tmp}"
  [ -n "${cwd}" ] && [ "${cwd}" != "${PWD}" ] && builtin cd -- "${cwd}"
  rm -f -- "${tmp}"
}
