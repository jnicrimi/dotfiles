#!/bin/bash

set -Ceu

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
    return 0
  fi
  ln -s "$_src_path" "$_dst_path"
  created_links+=("$_dst_path")
}

delete_symlink() {
  local _dst_path="$HOME"/"$1"
  unlink "$_dst_path"
  unlinked_files+=("$_dst_path")
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

dot_files=( .gitconfig .hushlogin )
for dot_file in "${dot_files[@]}"; do
  create_symlink "$dot_file"
done

directories=(
  ".claude"
  ".claude/agents"
  ".claude/commands"
  ".config/alacritty"
  ".config/bat"
  ".config/fish"
  ".config/fish/functions"
  ".config/gh"
  ".config/git"
  ".config/karabiner"
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
  ".claude/CLAUDE.md"
  ".claude/settings.json"
  ".config/alacritty/alacritty.toml"
  ".config/bat/config"
  ".config/fish/config.fish"
  ".config/fish/fish_plugins"
  ".config/gh/config.yml"
  ".config/git/attributes"
  ".config/git/ignore"
  ".config/karabiner/karabiner.json"
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

for fish_file_path in "$DOTFILES"/.config/fish/functions/*.fish; do
  file_name=$(basename "$fish_file_path")
  create_symlink ".config/fish/functions/$file_name"
done

broken_fish_links=$(find -L "$HOME"/.config/fish/functions -type l -name "*.fish")

for symlink in $broken_fish_links; do
  file_name=$(basename "$symlink")
  delete_symlink ".config/fish/functions/$file_name"
done

for plugin_file_path in "$DOTFILES"/.config/nvim/lua/plugins/*.lua; do
  file_name=$(basename "$plugin_file_path")
  create_symlink ".config/nvim/lua/plugins/$file_name"
done

broken_plugin_links=$(find -L "$HOME"/.config/nvim/lua/plugins -type l -name "*.lua")

for symlink in $broken_plugin_links; do
  file_name=$(basename "$symlink")
  delete_symlink ".config/nvim/lua/plugins/$file_name"
done

for command_file_path in "$DOTFILES"/.claude/commands/*.md; do
  file_name=$(basename "$command_file_path")
  create_symlink ".claude/commands/$file_name"
done

broken_command_links=$(find -L "$HOME"/.claude/commands -type l -name "*.md")

for symlink in $broken_command_links; do
  file_name=$(basename "$symlink")
  delete_symlink ".claude/commands/$file_name"
done

for agent_file_path in "$DOTFILES"/.claude/agents/*.md; do
  file_name=$(basename "$agent_file_path")
  create_symlink ".claude/agents/$file_name"
done

broken_agent_links=$(find -L "$HOME"/.claude/agents -type l -name "*.md")

for symlink in $broken_agent_links; do
  file_name=$(basename "$symlink")
  delete_symlink ".claude/agents/$file_name"
done

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
