function fgwt
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l git_root (git rev-parse --show-toplevel)
  set -l original_dir_name (basename "$git_root")
  set -l parent_dir (dirname "$git_root")
  set -l current_branch (git branch --show-current)
  set -l branches (git branch --format="%(refname:short)" | string match -v -x "$current_branch")
  if test -z "$branches"
    echo "No other branches found"
    return 0
  end
  set -l selected_branch (echo "$branches" | fzf)
  if test -z "$selected_branch"
    echo "No branch selected"
    return 0
  end
  set -l worktree_name "$original_dir_name-"(string replace -a "/" "-" "$selected_branch")
  set -l worktree_path "$parent_dir/$worktree_name"
  if test -d "$worktree_path"
    echo "Error: Worktree '$worktree_name' already exists at $worktree_path" >&2
    return 1
  end
  echo "Creating worktree: $worktree_name"
  echo "Path: $worktree_path"
  echo "Branch: $selected_branch"
  git worktree add "$worktree_path" "$selected_branch"
  if test $status -eq 0
    echo "Successfully created worktree at: $worktree_path"
    read -P "Do you want to cd to the new worktree? [y/N] " -l confirm
    if test "$confirm" = "y" -o "$confirm" = "Y"
      cd "$worktree_path"
    end
  else
    echo "Error: Failed to create worktree" >&2
    return 1
  end
end
