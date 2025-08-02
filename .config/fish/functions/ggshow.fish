function ggshow

  _assert_in_git_repository
  or return 1

  argparse -n ggshow 'p/path' -- $argv
  or return 1

  set -l commit_hash
  if set -lq _flag_path
    set -l selected_file (git ls-files | fzf --preview 'bat --color=always {} 2>/dev/null || cat {}')
    if test -z "$selected_file"
      echo "No file selected" >&2
      return 0
    end
    set commit_hash (_select_commit "$selected_file")
  else
    set commit_hash (_select_commit)
  end
  or return 0

  git show "$commit_hash"
end
