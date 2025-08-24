set -gx EDITOR nvim
set -gx FZF_DEFAULT_OPTS "--height 100% --reverse --border=rounded --no-sort --exit-0 --ansi --info=inline --preview-window=right:50%:wrap --bind 'ctrl-/:preview-page-down,ctrl-\:preview-page-up'"
set -gx LANG ja_JP.UTF-8
set -gx XDG_CONFIG_HOME $HOME/.config

set -g fish_greeting ""

fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

alias cat "bat --paging=never"
alias chrome "open -a 'Google Chrome'"
alias cp "cp -i"
alias la "eza -al --icons --git --group-directories-first"
alias less "bat --paging=always"
alias ll "eza -l --icons --git --group-directories-first"
alias ls "eza"
alias mv "mv -i"
alias rm "rm -i"
alias tree "eza -aT --icons --git-ignore"
alias vi "nvim"
alias vim "nvim"

abbr --add c 'claude'
abbr --add d 'docker'
abbr --add dc 'docker compose'
abbr --add g 'git'
abbr --add ga 'git add'
abbr --add gaa 'git add --all'
abbr --add gb 'git branch'
abbr --add gbr 'git branch --remote'
abbr --add gci 'git commit'
abbr --add gsw 'git switch'
abbr --add gd 'git diff'
abbr --add gdc 'git diff --cached'
abbr --add gdr 'git diff origin/(git rev-parse --abbrev-ref HEAD)..(git rev-parse --abbrev-ref HEAD)'
abbr --add gf 'git fetch'
abbr --add gl "git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
abbr --add glg "git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --graph"
abbr --add gs 'git status --short --branch'
abbr --add gwt 'git worktree'
abbr --add p 'pwd'
abbr --add u 'cd ..'
abbr --add x 'exit'

function starship_transient_prompt_func
  starship module character
end

starship init fish | source
enable_transience

mise activate fish | source

zoxide init fish | source
