#!/usr/bin/env bash

set -x

rm -f ~/.zshrc ~/.gitconfig ~/.vimrc ~/.tmux.conf ~/.sqliterc ~/.npmrc \
  ~/.env ~/.ssh/config

rm -rf ~/.config/nvim ~/.config/pip ~/.config/go ~/.config/ghostty \
  ~/.config/zed ~/.config/zsh

CONFIG_DIR="$1"

ln -s "${CONFIG_DIR}"/dotfile/tmux.conf ~/.tmux.conf
ln -s "${CONFIG_DIR}"/dotfile/sqliterc ~/.sqliterc
ln -s "${CONFIG_DIR}"/dotfile/npmrc ~/.npmrc
ln -s "${CONFIG_DIR}"/dotfile/env ~/.env
ln -s "${CONFIG_DIR}"/dotfile/ssh_config ~/.ssh/config

ln -s "${CONFIG_DIR}"/zsh/zshrc ~/.zshrc
ln -s "${CONFIG_DIR}"/zsh ~/.config/zsh

ln -s "${CONFIG_DIR}"/git/gitconfig ~/.gitconfig
ln -s "${CONFIG_DIR}"/vim/vimrc ~/.vimrc

ln -s "${CONFIG_DIR}"/nvim ~/.config/nvim
ln -s "${CONFIG_DIR}"/pip ~/.config/pip
ln -s "${CONFIG_DIR}"/go ~/.config/go
ln -s "${CONFIG_DIR}"/ghostyy ~/.config/ghostty
ln -s "${CONFIG_DIR}"/zed ~/.config/zed
