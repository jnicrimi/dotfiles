set -x LANG ja_JP.UTF-8
set -x PATH /opt/homebrew/bin $PATH
set -x XDG_CONFIG_HOME $HOME/.config
set -x EDITOR nvim
set -x FZF_DEFAULT_OPTS "--border --height 30% --reverse --no-sort --exit-0"

set -x NODENV_ROOT $HOME/.anyenv/envs/nodenv
set -x PATH $NODENV_ROOT/bin $PATH
set -x PATH $NODENV_ROOT/shims $PATH

alias g "git"
alias la "exa -aal --icons"
alias ll "exa -l --icons"
alias ls "exa --icons"
alias p "pwd"
alias u "cd .."
alias vi "vim"
alias vim "nvim"

if test -e $XDG_CONFIG_HOME/fish/config.local.fish
  source $XDG_CONFIG_HOME/fish/config.local.fish
end

starship init fish | source
