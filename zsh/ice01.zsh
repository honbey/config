function _count_graveyard() {
  local size=$(du --summarize --bytes /opt/data/graveyard | awk '{print $1}')
  if [[ ${size} -gt 3221225472 ]]; then
    echo -e "\nThe graveyard space has exceeded 3GB.\nPlease clean it up!"
  elif [[ $1 == "run" ]]; then
    echo -e "Graveyard size: $((${size} / (2 ** 20)))MB."
  fi
}

_count_graveyard

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

_extra_complement
