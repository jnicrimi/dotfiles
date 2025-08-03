function ggmerge

  _assert_in_git_repository
  or return 1

  set -l selected_branch (_select_other_branch)
  or return 0
  set -l current_branch (git branch --show-current)

  set -l merge_type (echo -e "merge\nsquash merge" | fzf --prompt="Merge type: ")
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
  end
end
