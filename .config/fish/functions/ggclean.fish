function ggclean

  _assert_in_git_repository
  or return 1

  if test -z (git status --porcelain)
    echo "No changes to stash"
    return 0
  end

  echo "Changes to discard:"
  git status --short
  echo ""

  _confirm_operation "Discard all changes?"
  or return 0

  git stash push -u -m "Temporary stash by ggclean"
  git stash drop
  echo "All changes discarded"
end
