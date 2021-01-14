#!/bin/bash
# 此脚本用于自动备份 BitWarden 的文件
FILENAME=bitwarden_bak_$(date +"%Y-%m-%d").tar.gz
set -e
cd /root/bitwarden-server/data
tar czf $FILENAME ./*
mv $FILENAME /root/bitwarden-server/backup/
