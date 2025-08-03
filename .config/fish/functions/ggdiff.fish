function ggdiff --description "Show git differences"

  _assert_in_git_repository
  or return 1

  set -l selected_branch (_select_other_branch)
  or return 0
  set -l current_branch (git branch --show-current)

  set -l action (_select_menu "Action" "diff" "stat")
  or return 0

  switch "$action"
    case "diff"
      git diff "$selected_branch..$current_branch"
    case "stat"
      git diff --stat "$selected_branch..$current_branch"
    case '*'
      return 0
  end
end
