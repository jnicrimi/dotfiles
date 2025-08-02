function fgdiff

  _assert_in_git_repository
  or return 1

  argparse -n fgdiff 's/stat' -- $argv
  or return 1

  set -l selected_branch (_select_other_branch)
  or return 0
  set -l current_branch (git branch --show-current)

  if set -lq _flag_stat
    git diff --stat "$selected_branch..$current_branch"
  else
    git diff "$selected_branch..$current_branch"
  end
end
