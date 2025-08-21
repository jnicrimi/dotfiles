function ggwt --description "Manage git worktrees"

  _assert_in_git_repository
  or return 1

  set -l action (_select_menu "Action" "add" "remove")
  or return 0

  switch $action
    case add
      _ggwt_add
    case remove
      _ggwt_remove
    case '*'
      return 0
  end
end

function _ggwt_add
  set -l selected_branch (_select_other_branch)
  or return 0

  set -l worktree_path (_ggwt_generate_path "$selected_branch")
  set -l worktree_name (basename "$worktree_path")

  if test -d "$worktree_path"
    echo "Error: Worktree '$worktree_name' already exists at $worktree_path" >&2
    return 1
  end

  _set_commandline "git worktree add $worktree_path $selected_branch"
end

function _ggwt_remove
  set -l available_worktrees (_ggwt_list_removable_worktrees)

  if test (count $available_worktrees) -eq 0
    echo "No worktrees available to remove"
    return 0
  end

  set -l selected_worktree (printf '%s\n' $available_worktrees | \
      fzf --prompt="Worktree to remove: ")
  if test -z "$selected_worktree"
    return 0
  end

  _set_commandline "git worktree remove $selected_worktree"
end

function _ggwt_generate_path
  set -l branch_name $argv[1]
  set -l git_root (git rev-parse --show-toplevel)
  set -l original_dir_name (basename "$git_root")
  set -l parent_dir (dirname "$git_root")
  set -l safe_branch_name (string replace -a '/' '-' "$branch_name")

  echo "$parent_dir/$original_dir_name-$safe_branch_name"
end

function _ggwt_list_removable_worktrees
  set -l worktrees (git worktree list --porcelain | grep "^worktree" | cut -d' ' -f2-)
  set -l current_worktree (git rev-parse --show-toplevel)

  for worktree in $worktrees
    if test "$worktree" != "$current_worktree"
      echo $worktree
    end
  end
end
