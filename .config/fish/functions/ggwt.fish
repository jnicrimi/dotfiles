function ggwt

  _assert_in_git_repository
  or return 1

  set -l git_root (git rev-parse --show-toplevel)
  set -l original_dir_name (basename "$git_root")
  set -l parent_dir (dirname "$git_root")

  set -l selected_branch (_select_other_branch)
  or return 0

  set -l safe_branch_name (string replace -a -r '[/:]' '-' "$selected_branch")
  set -l worktree_name "$original_dir_name-$safe_branch_name"
  set -l worktree_path "$parent_dir/$worktree_name"

  if test -d "$worktree_path"
    echo "Error: Worktree '$worktree_name' already exists at $worktree_path" >&2

    return 1
  end

  _confirm_operation "create worktree: $worktree_name at $worktree_path"
  or return 0

  git worktree add "$worktree_path" "$selected_branch"
  or begin
    echo "Error: Failed to create worktree" >&2
    return 1
  end

  if _confirm_operation "cd: $worktree_path"
    cd "$worktree_path"
  end
end
