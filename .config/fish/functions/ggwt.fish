function ggwt

  _assert_in_git_repository
  or return 1

  set -l action (echo -e "add\nremove" | fzf --prompt="Action: ")
  or return 0

  switch $action
    case add
      set -l git_root (git rev-parse --show-toplevel)
      set -l original_dir_name (basename "$git_root")
      set -l parent_dir (dirname "$git_root")

      set -l selected_branch (_select_other_branch)
      or return 0

      set -l safe_branch_name (string replace -a '/' '-' "$selected_branch")
      set -l worktree_name "$original_dir_name-$safe_branch_name"
      set -l worktree_path "$parent_dir/$worktree_name"

      if test -d "$worktree_path"
        echo "Error: Worktree '$worktree_name' already exists at $worktree_path" >&2
        return 1
      end

      _confirm_operation "Create worktree" "git worktree add $worktree_path $selected_branch"
      or return 0

      git worktree add "$worktree_path" "$selected_branch"
      or begin
        echo "Error: Failed to create worktree" >&2
        return 1
      end

      echo "Worktree created: $worktree_path"

      if _confirm_operation "Change directory" "cd $worktree_path"
        cd "$worktree_path"
      end

    case remove
      set -l worktrees (git worktree list --porcelain | grep "^worktree" | cut -d' ' -f2-)
      set -l current_worktree (git rev-parse --show-toplevel)

      set -l available_worktrees
      for worktree in $worktrees
        if test "$worktree" != "$current_worktree"
          set available_worktrees $available_worktrees $worktree
        end
      end

      if test (count $available_worktrees) -eq 0
        echo "No worktrees available to remove"
        return 0
      end

      set -l selected_worktree (printf '%s\n' $available_worktrees | fzf --prompt="Worktree to remove: ")
      if test -z "$selected_worktree"
        return 0
      end

      _confirm_operation "Remove worktree" "git worktree remove $selected_worktree"
      or return 0

      git worktree remove "$selected_worktree"
      or begin
        echo "Error: Failed to remove worktree" >&2
        return 1
      end

      echo "Worktree removed: $selected_worktree"
  end
end
