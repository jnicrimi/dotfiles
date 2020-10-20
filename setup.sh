#!/bin/bash

set -eu

create_symlink() {
  if [ -L "${1}" ]; then
    echo "exists: ${1}"
    return 0
  fi
  if [ -f "${1}" ]; then
    rm ${1}
    echo "delete: ${1}"
  fi
  ln -s ${2} ${1}
  echo "create: ${1} -> ${2}"
}

delete_symlink() {
  unlink ${1}
  echo "unlink: ${1}"
}

read -p "Setup dotfiles? (y/N) " answer

if [ ${answer} != "y" -a ${answer} != "Y" ]; then
  exit
fi

readonly BASE_DIRECTORY=$(cd $(dirname $0); pwd)

cd ${BASE_DIRECTORY}

dot_files=( .editorconfig .gitconfig .hushlogin .tmux.conf )

for dot_file in ${dot_files[@]}; do
  source_file="${BASE_DIRECTORY}/${dot_file}"
  target_file="${HOME}/${dot_file}"
  create_symlink ${target_file} ${source_file}
done

if [ ! -e "${HOME}/.config/alacritty" ]; then
  mkdir "${HOME}/.config/alacritty"
fi

source_file="${BASE_DIRECTORY}/.config/alacritty/alacritty.yml"
target_file="${HOME}/.config/alacritty/alacritty.yml"
create_symlink ${target_file} ${source_file}

if [ ! -e "${HOME}/.config/git" ]; then
  mkdir "${HOME}/.config/git"
fi

source_file="${BASE_DIRECTORY}/.config/git/attributes"
target_file="${HOME}/.config/git/attributes"
create_symlink ${target_file} ${source_file}

source_file="${BASE_DIRECTORY}/.config/git/ignore"
target_file="${HOME}/.config/git/ignore"
create_symlink ${target_file} ${source_file}

if [ ! -e "${HOME}/.config/nvim" ]; then
  mkdir "${HOME}/.config/nvim"
fi

source_file="${BASE_DIRECTORY}/.config/nvim/init.vim"
target_file="${HOME}/.config/nvim/init.vim"
create_symlink ${target_file} ${source_file}

source_file="${BASE_DIRECTORY}/.config/nvim/coc-settings.json"
target_file="${HOME}/.config/nvim/coc-settings.json"
create_symlink ${target_file} ${source_file}

if [ "$(uname)" == 'Darwin' ]; then
  if [ ! -e "${HOME}/.config/homebrew" ]; then
    mkdir "${HOME}/.config/homebrew"
  fi
  source_file="${BASE_DIRECTORY}/.config/homebrew/Brewfile"
  target_file="${HOME}/.config/homebrew/Brewfile"
  create_symlink ${target_file} ${source_file}

  source_file="${BASE_DIRECTORY}/.config/karabiner/karabiner.json"
  target_file="${HOME}/.config/karabiner/karabiner.json"
  create_symlink ${target_file} ${source_file}
fi

source_file="${BASE_DIRECTORY}/.config/fish/config.fish"
target_file="${HOME}/.config/fish/config.fish"
create_symlink ${target_file} ${source_file}

source_file="${BASE_DIRECTORY}/.config/fish/fishfile"
target_file="${HOME}/.config/fish/fishfile"
create_symlink ${target_file} ${source_file}

for source_file in ${BASE_DIRECTORY}/.config/fish/functions/*.fish; do
  target_file="${HOME}/.config/fish/functions/$(basename ${source_file})"
  create_symlink ${target_file} ${source_file}
done

if [ "$(uname)" == 'Darwin' ]; then
  symlinks=$(find -L ${HOME}/.config/fish/functions -type l -name "*.fish")
else
  symlinks=$(find ${HOME}/.config/fish/functions -xtype l -name "*.fish")
fi

for symlink in ${symlinks}; do
  delete_symlink ${symlink}
done
