set -gx LANG ja_JP.UTF-8
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EDITOR nvim
set -gx FZF_DEFAULT_OPTS "--border --height 30% --reverse --no-sort --exit-0"
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

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
alias u "cd .."
alias vi "vim"
alias vim "nvim"
if test -e $XDG_CONFIG_HOME/fish/config.local.fish
  source $XDG_CONFIG_HOME/fish/config.local.fish
end

starship init fish | source
