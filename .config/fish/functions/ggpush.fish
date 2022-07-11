function ggpush
  set -l branch (git rev-parse --abbrev-ref HEAD)
  set -l repository (git remote show)
  set -l prompt "push: $branch > origin/$branch"
  echo -e $prompt
  read -P "(yes/no) " -l confirm
  if test $confirm != "yes"
    return 0
  end
  git push $repository $branch
end
