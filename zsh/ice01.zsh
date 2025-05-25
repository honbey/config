function _count_graveyard() {
  local size=$(du -s /opt/data/graveyard | awk '{print $1}')
  if [[ ${size} -gt 3221225472 ]]; then
    echo -e "\nThe graveyard space has exceeded 3GB.\nPlease clean it up!"
  fi
}

_count_graveyard
