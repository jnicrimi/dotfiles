function fgshow
  set -l hash (git log --no-merges --pretty=format:"%h - %an : %s" | fzf | cut -d " " -f1)
  if test -n "$hash"
    git show $hash
  end
end
