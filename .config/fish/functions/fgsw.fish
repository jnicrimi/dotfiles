function fgsw
  set -l target_branch (git branch | fzf | sed -e "s/^\* *//g" | awk "{print \$1}")
  if test -n "$target_branch"
    git switch $target_branch
  end
end
