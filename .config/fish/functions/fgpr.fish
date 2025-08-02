function fgpr
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l hash (git log --no-merges --pretty=format:"%H - %an : %s" | fzf | cut -d " " -f1)
  if test -n "$hash"
    gh pr list -s all -S "$hash" -w
  else
    return 0
  end
end
