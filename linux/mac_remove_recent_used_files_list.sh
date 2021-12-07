#!/usr/bin/env bash
#

for file in $(/usr/bin/env ls )
do
  if [[ -f "${file}" ]]; then
    cp -a "${file}" "${file}_" \
    && rm -f "${file}" \
    && mv "${file}_" "${file}"
  fi
done