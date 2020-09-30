#!/bin/bash                                                                                                             # 这个脚本用于更改当前目录的下的非正常权限文件
# 为正常权限（文件：644，目录：755）
find . \
    \( \
    -type f \
    -not -perm 644 \
    -exec chmod 644 '{}' + \
    \) \
    -or \
    \( \
    -type d \
    -not -perm 755 \
    -exec chmod 755 '{}' + \
    \)
