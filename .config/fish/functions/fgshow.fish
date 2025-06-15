function fgshow
  argparse -n fgshow 'p/path=' -- $argv
  or return 1
  set -l hash
  if set -lq _flag_path
    set hash (git log --no-merges --pretty=format:"%H - %an : %s" "$_flag_path" | fzf | cut -d " " -f1)
  else
    set hash (git log --no-merges --pretty=format:"%H - %an : %s" | fzf | cut -d " " -f1)
  end
  if test -n "$hash"
    git show $hash
  end
end
