set -x LANG ja_JP.UTF-8
set -x SHELL (which fish)
set -x XDG_CONFIG_HOME $HOME/.config
set -x EDITOR nvim
set -x NODENV_ROOT $HOME/.anyenv/envs/nodenv
set -x FZF_DEFAULT_OPTS "--border --height 30% --reverse --no-sort --exit-0"

set -g fish_user_paths $HOME/.anyenv/bin $fish_user_paths
set -g fish_user_paths $HOME/.anyenv/envs/nodenv/bin $fish_user_paths
set -g fish_user_paths $NODENV_ROOT/shims $fish_user_paths

set -g theme_color_scheme gruvbox
set -g theme_date_format "+%H:%M:%S"
set -g theme_date_timezone Asia/Tokyo
set -g theme_newline_cursor yes

alias cpi "cp -i"
alias g "git"
alias grep "grep --color"
alias la "exa -aal --icons"
alias ll "exa -l --icons"
alias ls "exa --icons"
alias mvi "mv -i"
alias p "pwd"
alias rmi "rm -i"
alias u "cd .."
alias uu "cd ../.."
alias uuu "cd ../../.."
alias vi "vim"
alias vim "nvim"
alias vless "/usr/local/share/nvim/runtime/macros/less.sh"

if test -e $XDG_CONFIG_HOME/fish/config.local.fish
  source $XDG_CONFIG_HOME/fish/config.local.fish
end
