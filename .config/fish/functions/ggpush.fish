function ggpush

  _assert_in_git_repository
  or return 1

  set -l git_info (_get_git_remote)
  or return 1
  set -l branch $git_info[1]
  set -l remote $git_info[2]

  _confirm_operation "push: $branch > $remote/$branch"
  or return 0

  git push "$remote" "$branch"
end
