function ggpush

  _assert_in_git_repository
  or return 1

  set -l git_info (_get_git_remote)
  or return 1
  set -l branch $git_info[1]
  set -l remote $git_info[2]

  set -l push_type (_select_menu "Push type" "push" "force push")
  or return 0

  switch $push_type
    case "push"
      set -l push_command "git push $remote $branch"
      _confirm_operation "Push to remote" "$push_command"
      or return 0
      git push "$remote" "$branch"
    case "force push"
      set -l push_command "git push -f $remote $branch"
      _confirm_operation "Force push to remote" "$push_command"
      or return 0
      git push -f "$remote" "$branch"
    case '*'
      return 0
  end
end
