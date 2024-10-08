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
alias d "docker"
alias g "git"
alias h "history"
alias hc "history clear"
alias la "eza -al --icons --git"
alias less "bat"
alias ll "eza -l --icons --git"
alias ls "eza"
alias mv "mv -i"
alias p "pwd"
alias rm "rm -i"
alias tree "eza -aT --icons --git-ignore"
alias u "cd .."
alias vi "nvim"
alias vim "nvim"
alias x "exit"

starship init fish | source
