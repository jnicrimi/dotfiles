function ggshow

  _assert_in_git_repository
  or return 1

  set -l action (_select_menu "Action" "commit" "file")
  or return 0

  set -l commit_hash
  switch "$action"
    case "commit"
      set commit_hash (_select_commit)
    case "file"
      set -l selected_file (git ls-files | fzf --prompt="File: " --preview 'bat --color=always {q} 2>/dev/null || cat {q}')
      if test -z "$selected_file"
        return 0
      end
      set commit_hash (_select_commit "$selected_file")
    case '*'
      return 0
  end
  or return 0

  git show "$commit_hash"
end
