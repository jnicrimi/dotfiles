function ggdel

  _assert_in_git_repository
  or return 1

  set -l selected_branch (_select_other_branch)
  or return 0

  _confirm_operation "Delete branch" "git branch -D $selected_branch"
  or return 0

  git branch -D "$selected_branch"
end
