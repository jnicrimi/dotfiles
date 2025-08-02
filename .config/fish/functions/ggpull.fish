function ggpull
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l branch (git rev-parse --abbrev-ref HEAD)
  set -l remote (git config --get branch.$branch.remote)
  if test -z "$remote"
    echo "Error: No upstream remote configured for branch '$branch'" >&2
    return 1
  end
  git pull "$remote" "$branch"
end
