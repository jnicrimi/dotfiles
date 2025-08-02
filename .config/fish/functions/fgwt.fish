function fgwt
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository"
    return 1
  end
  set -l git_root (git rev-parse --show-toplevel)
  set -l original_dir_name (basename "$git_root")
  set -l parent_dir (dirname "$git_root")
  set -l current_branch (git branch --show-current)
  set -l selected_branch (git branch --format="%(refname:short)" | \
    string match -v "$current_branch" | fzf)
  if test -z "$selected_branch"
    echo "No branch selected"
    return 1
  end
  set -l worktree_name "$original_dir_name-$selected_branch"
  set -l worktree_path "$parent_dir/$worktree_name"
  if test -d "$worktree_path"
    echo "Error: Worktree '$worktree_name' already exists at $worktree_path"
    return 1
  end
  echo "Creating worktree: $worktree_name"
  echo "Path: $worktree_path"
  echo "Branch: $selected_branch"
  git worktree add "$worktree_path" "$selected_branch"
  if test $status -eq 0
    echo "Successfully created worktree at: $worktree_path"
    read -l -P "Do you want to cd to the new worktree? [y/N] " confirm
    if test "$confirm" = "y" -o "$confirm" = "Y"
      cd "$worktree_path"
    end
  else
    echo "Error: Failed to create worktree"
    return 1
  end
end
