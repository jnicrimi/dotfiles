function ggrebase

  _assert_in_git_repository
  or return 1

  set -l commit_hash (git log --oneline | fzf --prompt="Commit for rebase: " --preview 'git show --color=always {1}' --preview-window=right:60% | awk '{print $1}')

  if test -z "$commit_hash"
    echo "No commit selected" >&2
    return 0
  end

  if git rev-parse --quiet "$commit_hash^" >/dev/null 2>&1
    git rebase -i "$commit_hash^"
  else
    echo "Selected commit has no parent – nothing to rebase" >&2
    return 1
  end
end
