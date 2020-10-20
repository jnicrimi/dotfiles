function fglog
  set -l target_branch (git branch | fzf | sed -e "s/\* //g" | sed -e 's/^ *//' | awk "{print \$1}")
  set -l current_branch (git rev-parse --abbrev-ref HEAD)
  if test -z "$target_branch"
    return 0
  end
  git log --no-merges $target_branch..$current_branch
end
