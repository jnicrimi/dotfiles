function fgsw
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l target_branch (git branch | fzf | sed -e "s/^\* *//g" | awk "{print \$1}")
  if test -n "$target_branch"
    git switch $target_branch
  end
end
