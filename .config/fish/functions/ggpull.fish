function ggpull
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l branch (git rev-parse --abbrev-ref HEAD)
  set -l remote (git config --get branch.$branch.remote 2>/dev/null)
  if test -z "$remote"
    set remote (git remote | head -1)
  end
  if test -z "$remote"
    echo "Error: No remote repository configured" >&2
    return 1
  end
  git pull "$remote" "$branch"
end
