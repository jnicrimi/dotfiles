function ggrestore --description "Restore file changes interactively with fzf"

  _assert_in_git_repository
  or return 1

  set -l git_root (git rev-parse --show-toplevel)

  set -l changed_files (git status --porcelain -z | \
      string split0 | \
      string match -v '' | \
      grep -v '^??' | \
      grep -v '^A[MD ]' | \
      sed 's/^...//')

  if test (count $changed_files) -eq 0
    echo "No changes to restore"
    return 0
  end

  set -l selected_files (printf '%s\n' $changed_files | \
    fzf --multi \
        --prompt="Select files: " \
        --preview "git -C $git_root diff HEAD --color=always {} 2>/dev/null || \
                   bat --color=always $git_root/{} 2>/dev/null || \
                   cat $git_root/{}")

  if test (count $selected_files) -eq 0
    return 0
  end

  echo "Files to restore:"
  for file in $selected_files
    echo "  $file"
  end

  _confirm_operation "Restore these files to their original state?"
  or return 0

  git -C $git_root restore --staged --worktree -- $selected_files
  echo "Files restored"
end
