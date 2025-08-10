function _select_commit

  set -l current_branch (git branch --show-current)
  set -l path_filter ""
  if test (count $argv) -gt 0
    set path_filter $argv[1]
  end

  set -l commit_hash

  if test -n "$path_filter"
    set commit_hash (git log --color=never --pretty=format:"%H - %an : %s" -- "$path_filter" | \
        fzf --prompt="Commit: " \
            --header="$current_branch" \
            --preview 'git show --color=always {1}' | \
        cut -d " " -f1)
  else
    set commit_hash (git log --color=never --pretty=format:"%H - %an : %s" | \
        fzf --prompt="Commit: " \
            --header="$current_branch" \
            --preview 'git show --color=always {1}' | \
        cut -d " " -f1)
  end

  if test -z "$commit_hash"
    return 1
  end

  echo $commit_hash
  return 0
end
