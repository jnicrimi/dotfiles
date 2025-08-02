function fgshow
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  argparse -n fgshow 'p/path=' -- $argv
  or return 1
  set -l commit_hash
  if set -lq _flag_path
    set commit_hash (git log --no-merges --pretty=format:"%H - %an : %s" "$_flag_path" | fzf | cut -d " " -f1)
  else
    set commit_hash (git log --no-merges --pretty=format:"%H - %an : %s" | fzf | cut -d " " -f1)
  end
  if test -n "$commit_hash"
    git show "$commit_hash"
  else
    echo "No commit selected"
    return 0
  end
end
