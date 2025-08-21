function ggclean --description "Discard all git changes"

  _assert_in_git_repository
  or return 1

  set -l changes (git status --porcelain)
  if test -z "$changes"
    echo "No changes to stash"
    return 0
  end

  echo "Changes to discard:"
  git status --short

  _set_commandline "git stash push -u && git stash drop"
end
