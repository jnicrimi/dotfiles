function fgco
  set -l target_branch (git branch | fzf -e | sed -e "s/\* //g" | sed -e 's/^ *//' | awk "{print \$1}")
  if test -n "$target_branch"
    git checkout $target_branch
  end
end
