function fgmerge
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l current_branch (git branch --show-current)
  set -l target_branch (git branch --format="%(refname:short)" | \
    string match -v "$current_branch" | fzf)
  if test -z "$target_branch"
    echo "No branch selected"
    return 1
  end
  set -l prompt "merge: $target_branch > $current_branch"
  echo "$prompt"
  read -P "[y/N] " -l confirm
  if test "$confirm" != "y" -a "$confirm" != "Y"
    return 0
  end
  git merge "$target_branch"
end
