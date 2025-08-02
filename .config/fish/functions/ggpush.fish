function ggpush
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l branch (git rev-parse --abbrev-ref HEAD)
  set -l repository (git remote show)
  set -l prompt "push: $branch > origin/$branch"
  echo "$prompt"
  read -P "[y/N] " -l confirm
  if test "$confirm" != "y" -a "$confirm" != "Y"
    return 0
  end
  git push "$repository" "$branch"
end
