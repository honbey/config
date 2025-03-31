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
function be() {
  base64 <(echo "$1")
}
function bd() {
  base64 --decode <(echo "$1")
}

# URL encode/decode
# https://unix.stackexchange.com/a/678894
function ue() {
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
function ud() { echo -e "${1//\%/\\x}" }

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
