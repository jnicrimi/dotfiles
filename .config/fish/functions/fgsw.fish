function fgsw
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l target_branch (git branch --format="%(refname:short)" | fzf)
  if test -n "$target_branch"
    git switch "$target_branch"
  else
    return 0
  end
end
