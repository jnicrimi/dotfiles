#!/bin/bash

set -Ceuo pipefail

SCRIPT_DIRECTORY=$(dirname "$0")

readonly SCRIPT_DIRECTORY

DOTFILES=$(cd "$SCRIPT_DIRECTORY"; pwd)

readonly DOTFILES

created_links=()
unlinked_files=()

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
    if [ "$(readlink "$_dst_path")" = "$_src_path" ]; then
      return 0
    fi
    unlink "$_dst_path"
    unlinked_files+=("$_dst_path")
  fi
  ln -s "$_src_path" "$_dst_path"
  created_links+=("$_dst_path")
}

delete_symlink() {
  local _dst_path="$HOME"/"$1"
  unlink "$_dst_path"
  unlinked_files+=("$_dst_path")
}

sync_symlinks() {
  local dir_path="$1"
  local file_pattern="$2"

  for file_path in "$DOTFILES"/"$dir_path"/$file_pattern; do
    [ -e "$file_path" ] || continue
    file_name=$(basename "$file_path")
    create_symlink "$dir_path/$file_name"
  done

  local broken_links
  broken_links=$(find -L "$HOME"/"$dir_path" -type l -name "$file_pattern" 2>/dev/null)

  if [ -n "$broken_links" ]; then
    for symlink in $broken_links; do
      file_name=$(basename "$symlink")
      delete_symlink "$dir_path/$file_name"
    done
  fi
}

while true; do
  read -rp "[y/n] " answer
  case "$answer" in
    y|Y)
      break
      ;;
    n|N)
      exit
      ;;
    *)
      continue
      ;;
  esac
done

echo -n -e "\n"

directories=(
  ".claude"
  ".claude/agents"
  ".claude/commands"
  ".codex"
  ".config/alacritty"
  ".config/bat"
  ".config/bat/themes"
  ".config/fish"
  ".config/fish/functions"
  ".config/gh"
  ".config/git"
  ".config/karabiner"
  ".config/mise"
  ".config/nvim"
  ".config/nvim/lua"
  ".config/nvim/lua/config"
  ".config/nvim/lua/core"
  ".config/nvim/lua/plugins"
  ".config/zellij"
)

for dir in "${directories[@]}"; do
  create_directory "$dir"
done

config_files=(
  "AGENTS.md"
  ".claude/settings.json"
  ".codex/config.toml"
  ".config/alacritty/alacritty.toml"
  ".config/bat/config"
  ".config/fish/config.fish"
  ".config/fish/fish_plugins"
  ".config/gh/config.yml"
  ".config/git/config"
  ".config/git/attributes"
  ".config/git/ignore"
  ".config/karabiner/karabiner.json"
  ".config/mise/config.toml"
  ".config/nvim/init.lua"
  ".config/nvim/lua/config/lazy.lua"
  ".config/nvim/lua/core/options.lua"
  ".config/nvim/lua/core/keymaps.lua"
  ".config/starship.toml"
  ".config/zellij/config.kdl"
)

for config_file in "${config_files[@]}"; do
  create_symlink "$config_file"
done

create_symlink "AGENTS.md"
ln -sf "$DOTFILES/AGENTS.md" "$HOME/.claude/CLAUDE.md"

create_symlink ".default-npm-packages"

sync_symlinks ".config/fish/functions" "*.fish"
sync_symlinks ".config/nvim/lua/plugins" "*.lua"
sync_symlinks ".claude/commands" "*.md"
sync_symlinks ".claude/agents" "*.md"
sync_symlinks ".config/bat/themes" "*.tmTheme"

if [ ${#created_links[@]} -gt 0 ]; then
  echo "Created symlinks (${#created_links[@]}):"
  for link in "${created_links[@]}"; do
    echo "  ✓ $link"
  done
fi

if [ ${#unlinked_files[@]} -gt 0 ]; then
  echo "Removed broken links (${#unlinked_files[@]}):"
  for link in "${unlinked_files[@]}"; do
    echo "  ✗ $link"
  done
fi

if [ ${#created_links[@]} -eq 0 ] && [ ${#unlinked_files[@]} -eq 0 ]; then
  echo "No changes"
fi
