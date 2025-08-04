function ggsw --description "Switch git branch"

  _assert_in_git_repository
  or return 1

  set -l selected_branch (_select_other_branch)
  or return 0

  git switch "$selected_branch"
end
