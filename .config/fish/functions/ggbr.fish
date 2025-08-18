function ggbr --description "Manage git branches"

  _assert_in_git_repository
  or return 1

  set -l action (_select_menu "Action" "merge" "create" "rename" "delete")
  or return 0

  switch $action
    case merge
      _ggbr_merge
    case create
      _ggbr_create
    case rename
      _ggbr_rename
    case delete
      _ggbr_delete
    case '*'
      return 0
  end
end

function _ggbr_merge
  set -l selected_branch (_select_other_branch)
  or return 0

  set -l merge_type (_select_menu "Merge type" "merge" "squash merge")
  or return 0

  switch $merge_type
    case "merge"
      _confirm_operation "Merge branch" "git merge $selected_branch"
      or return 0
      git merge "$selected_branch"
    case "squash merge"
      _confirm_operation "Squash merge branch" "git merge --squash $selected_branch"
      or return 0
      git merge --squash "$selected_branch"
    case '*'
      return 0
  end
end

function _ggbr_create
  set -l branch_prefixes \
    "feature" \
    "fix" \
    "refactor" \
    "chore" \
    "docs" \
    "hotfix" \
    "release"

  set -l branch_prefix (_select_menu "Prefix type" $branch_prefixes)
  or return 0

  read -P "Branch name: " -c "$branch_prefix/" branch_name
  or return 0

  _ggbr_validate_branch_name "$branch_name"
  or return $status

  _confirm_operation "Create branch" "git switch -c $branch_name"
  or return 0

  git switch -c "$branch_name"
end

function _ggbr_rename
  set -l current_branch (git branch --show-current)

  if test -z "$current_branch"
    echo "Error: Cannot rename branch in detached HEAD state" >&2
    return 1
  end

  read -P "Branch name: " -c "$current_branch" branch_name
  or return 0

  _ggbr_validate_branch_name "$branch_name"
  or return $status

  _confirm_operation "Rename branch" "git branch -m $branch_name"
  or return 0

  git branch -m "$branch_name"
end

function _ggbr_delete
  set -l selected_branch (_select_other_branch)
  or return 0

  _confirm_operation "Delete branch" "git branch -D $selected_branch"
  or return 0

  git branch -D "$selected_branch"
end

function _ggbr_validate_branch_name
  set -l branch_name $argv[1]

  if test -z "$branch_name"
    echo "Error: No branch name entered" >&2
    return 1
  end

  if not git check-ref-format --branch "$branch_name" 2>/dev/null
    echo "Error: Invalid branch name" >&2
    return 1
  end

  return 0
end
