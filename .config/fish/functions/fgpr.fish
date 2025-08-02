function fgpr
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l commit_hash (git log --no-merges --pretty=format:"%H - %an : %s" | fzf | cut -d " " -f1)
  if test -n "$commit_hash"
    gh pr list -s all -S "$commit_hash" -w
  else
    echo "No commit selected"
    return 0
  end
end
