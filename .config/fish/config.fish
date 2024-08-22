set -gx EDITOR vim
set -gx FZF_DEFAULT_OPTS "--border --height 30% --reverse --no-sort --exit-0"
set -gx LANG ja_JP.UTF-8
set -gx VOLTA_HOME $HOME/.volta
set -gx XDG_CONFIG_HOME $HOME/.config

fish_add_path $VOLTA_HOME/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

alias cat "bat --paging=never"
alias chrome "open -a 'Google Chrome'"
alias cp "cp -i"
alias g "git"
alias la "eza -al --icons"
alias less "bat"
alias ll "eza -l --icons"
alias ls "eza"
alias mv "mv -i"
alias p "pwd"
alias rm "rm -i"
alias tree "eza -T"
alias u "cd .."
alias vi "vim"
alias vim "nvim"

starship init fish | source
