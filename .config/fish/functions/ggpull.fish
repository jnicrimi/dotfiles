function ggpull
  set -l branch (git rev-parse --abbrev-ref HEAD)
  set -l repository (git remote show)
  git pull $repository $branch
end
