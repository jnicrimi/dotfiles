function _select_other_branch

  set -l current_branch (git branch --show-current)
  set -l escaped_branch (string escape --style=regex "$current_branch")
  set -l branches (git branch --color=never --format="%(refname:short)" | string match -r -v "^$escaped_branch\$")

  if test -z "$branches"
    echo "No other branches found" >&2
    return 1
  end

  set -l selected_branch (printf '%s\n' $branches | fzf --prompt="Branch: " --preview 'git log --color=always --oneline -n 30 {}')

  if test -z "$selected_branch"
    return 1
  end

  echo $selected_branch
  return 0
end
