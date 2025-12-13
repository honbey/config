# Count the disk space occupied by the recycling bin directory `graveyard`
# by `rip(rm-improved)` and clear when space more than 3GB automatically.
#    * return null
function _count_graveyard() {
  local size=$(du --summarize --bytes /opt/data/graveyard | awk '{print $1}')
  if [[ ${size} -gt 3221225472 ]]; then
    echo -e "\nThe graveyard space has exceeded 3GB.\nPlease clean it up!"
  elif [[ $1 == "run" ]]; then
    echo -e "Graveyard size: $((${size} / (2 ** 20)))MB."
  fi
}

# Add extra some completion information which not installed by `brew`.
#    * return null
function _extra_complement() {
  local BREW
  BREW="/opt/homebrew"
  # curl's complement not load on macOS.
  if [[ -d "${BREW}/opt/curl/share/zsh/site-functions" ]]; then
    [[ -f "${BREW}/share/zsh/site-functions/_curl" ]] ||
      ln -s "${BREW}/opt/curl/share/zsh/site-functions/_curl" \
        "${BREW}/share/zsh/site-functions/_curl"
  fi
}

# `jq` depth to show.
#   $1 int: depth, default 1
#   * return null
function jqd() {
  # echo "Usage: jqd <depth> [input-file]"
  local depth
  if [[ $# -lt 1 ]]; then
    depth=1
  else
    depth=$1
  fi

  local input_file=${2:-/dev/stdin}

  jq --argjson depth "$depth" 'def truncate($depth):
        if $depth <= 0 then
            if type == "object" then "{...}"
            elif type == "array" then "[...]"
            else .
            end
        else
            if type == "object" then
                . as $in | reduce keys[] as $key ({}; .[$key] = ($in[$key] | truncate($depth-1)))
            elif type == "array" then
                map(truncate($depth-1))
            else
                .
            end
        end;
    truncate($depth)' "$input_file"
}

###################################
# the functions need be processed #
###################################
_count_graveyard
_extra_complement
