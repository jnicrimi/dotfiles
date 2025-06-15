function fgpr
  set hash (git log --no-merges --pretty=format:"%H - %an : %s" | fzf | cut -d " " -f1)
  if test -n "$hash"
    gh pr list -s all -S $hash -w
  end
end
