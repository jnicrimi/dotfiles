function ggclean

  _assert_in_git_repository
  or return 1

  if test -z (git status --porcelain)
    echo "No changes to stash"
    return 0
  end

  git add -A
  git stash push -m "Temporary stash by ggclean"
  git stash drop
  echo "All changes have been stashed and dropped"
end
