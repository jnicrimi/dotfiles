#!/bin/bash

set -Ceu

SCRIPT_DIRECTORY=$(dirname "$0")

readonly SCRIPT_DIRECTORY

DOTFILES=$(cd "$SCRIPT_DIRECTORY"; pwd)

readonly DOTFILES

create_directory() {
  local _dir_path="$HOME"/"$1"
  if [ ! -e "$_dir_path" ]; then
    mkdir -p "$_dir_path"
  fi
}

create_symlink() {
  local _src_path="$DOTFILES"/"$1"
  local _dst_path="$HOME"/"$1"
  if [ -L "$_dst_path" ]; then
    echo "exists: $_dst_path"
    return 0
  fi
  ln -s "$_src_path" "$_dst_path"
  echo "create: $_dst_path"
}

delete_symlink() {
  local _dst_path="$HOME"/"$1"
  unlink "$_dst_path"
  echo "unlink: $_dst_path"
}

read -rp "Setup dotfiles? (yes/no) " answer
if [ "$answer" != "yes" ]; then
  exit
fi

echo -n -e "\n"

dot_files=( .gitconfig .hushlogin )
for dot_file in "${dot_files[@]}"; do
  create_symlink "$dot_file"
done

create_directory .claude
create_directory .config/alacritty
create_directory .config/bat
create_directory .config/fish
create_directory .config/fish/functions
create_directory .config/gh
create_directory .config/git
create_directory .config/nvim
create_directory .config/zellij

create_symlink .claude/CLAUDE.md
create_symlink .claude/settings.json
create_symlink .config/alacritty/alacritty.toml
create_symlink .config/bat/config
create_symlink .config/fish/config.fish
create_symlink .config/fish/fish_plugins
create_symlink .config/gh/config.yml
create_symlink .config/git/attributes
create_symlink .config/git/ignore
create_symlink .config/nvim/init.vim
create_symlink .config/starship.toml
create_symlink .config/zellij/config.kdl

for fish_file_path in "$DOTFILES"/.config/fish/functions/*.fish; do
  fish_file_name=$(basename "$fish_file_path")
  create_symlink .config/fish/functions/"$fish_file_name"
done

symlinks=$(find -L "$HOME"/.config/fish/functions -type l -name "*.fish")

for symlink in $symlinks; do
  fish_file_name=$(basename "$symlink")
  delete_symlink .config/fish/functions/"$fish_file_name"
done
