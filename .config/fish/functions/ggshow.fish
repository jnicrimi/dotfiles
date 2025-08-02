function ggshow

  _assert_in_git_repository
  or return 1

  argparse -n ggshow 'p/path=' -- $argv
  or return 1

  set -l commit_hash
  if set -lq _flag_path
    set commit_hash (_select_commit "$_flag_path")
  else
    set commit_hash (_select_commit)
  end
  or return 0

  git show "$commit_hash"
end
