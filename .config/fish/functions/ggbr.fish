function ggbr

  _assert_in_git_repository
  or return 1

  set -l action (_select_menu "Action" "switch" "merge" "delete")
  or return 0

  switch $action
    case switch
      _ggbr_switch
    case merge
      _ggbr_merge
    case delete
      _ggbr_delete
    case '*'
      return 0
  end
end

function _ggbr_switch
  set -l selected_branch (_select_other_branch)
  or return 0

  git switch "$selected_branch"
end

function _ggbr_merge
  set -l selected_branch (_select_other_branch)
  or return 0

  set -l merge_type (_select_menu "Merge type" "merge" "squash merge")
  or return 0

  switch $merge_type
    case "merge"
      set -l merge_command "git merge $selected_branch"
      _confirm_operation "Merge branch" "$merge_command"
      or return 0
      git merge "$selected_branch"
    case "squash merge"
      set -l merge_command "git merge --squash $selected_branch"
      _confirm_operation "Squash merge branch" "$merge_command"
      or return 0
      git merge --squash "$selected_branch"
    case '*'
      return 0
  end
end

function _ggbr_delete
  set -l selected_branch (_select_other_branch)
  or return 0

  _confirm_operation "Delete branch" "git branch -D $selected_branch"
  or return 0

  git branch -D "$selected_branch"
end
