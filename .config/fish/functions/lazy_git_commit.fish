function lazy_git_commit
  if not git_is_repo
    echo "not a git repository" >&2
    return 1
  end
  if not git_is_staged
    if git_is_dirty
      echo "changes not staged for commit" >&2
      return 1
    else
      echo "repository is clean"
      return 0
    end
  end
  set -l shortstat (string trim -- (git diff --cached --shortstat))
  git commit -m "lazy commit : $shortstat"
end
