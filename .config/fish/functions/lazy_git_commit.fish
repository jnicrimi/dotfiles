function lazy_git_commit
  set -l shortstat (string trim -- (git diff --cached --shortstat))
  git commit -m "lazy commit : $shortstat"
end
