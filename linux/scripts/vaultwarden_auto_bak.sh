#!/usr/bin/env bash
# 此脚本用于自动备份 Vaultwarden(Bitwarden) 的文件

# crontab -e
# 0 0 15 * * /path/vaultwarden_auto_bak.sh $1

set -e

FILE_NAME="vaultwarden-$(date +"%Y%m%d").tar.gz"

file_path="${1}"
cd "${file_path}/data/"
tar czf "${FILE_NAME}" --exclude "icon_cache" ./*
mv "${FILE_NAME}" "${file_path}/backups/"
