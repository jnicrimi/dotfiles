function fgsw
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l current_branch (git branch --show-current)
  set -l branches (git branch --format="%(refname:short)" | string match -r -v "^$current_branch\$")
  if test -z "$branches"
    echo "No other branches found"
    return 0
  end
  set -l selected_branch (echo "$branches" | fzf)
  if test -z "$selected_branch"
    echo "No branch selected"
    return 0
  end
  git switch "$selected_branch"
end
