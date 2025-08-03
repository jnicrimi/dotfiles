function ggcommit --description "Manage git commits and pull requests"

  _assert_in_git_repository
  or return 1

  set -l select_type (_select_menu "Select type" "commit" "file")
  or return 0

  set -l commit_hash
  switch "$select_type"
    case "commit"
      set commit_hash (_select_commit)
    case "file"
      set -l selected_file (git ls-files | fzf --prompt="File: " --preview 'bat --color=always {} 2>/dev/null || cat {}')
      if test -z "$selected_file"
        return 0
      end
      set commit_hash (_select_commit "$selected_file")
    case '*'
      return 0
  end
  or return 0

  set -l action (_select_menu "Action" "show" "browse")
  or return 0

  switch "$action"
    case "show"
      git show "$commit_hash"
    case "browse"
      gh pr list -s all -S "commit:$commit_hash" -w
    case '*'
      return 0
  end
end
