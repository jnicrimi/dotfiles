function ggpr

  _assert_in_git_repository
  or return 1

  set -l commit_hash (_select_commit)
  or return 0

  gh pr list -s all -S "commit:$commit_hash" -w
end
