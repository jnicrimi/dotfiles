function ggmerge

  _assert_in_git_repository
  or return 1

  set -l selected_branch (_select_other_branch)
  or return 0
  set -l current_branch (git branch --show-current)

  _confirm_operation "merge: $selected_branch > $current_branch"
  or return 0

  git merge "$selected_branch"
end
