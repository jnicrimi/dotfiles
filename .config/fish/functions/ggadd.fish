function ggadd --description "Add unstaged files interactively with fzf"

  _assert_in_git_repository
  or return 1

  set -l unstaged_files (git status --porcelain -z | \
      string split0 | \
      grep -E "^.[ACDMRT]|^\?\?" | \
      sed 's/^...//')

  if test (count $unstaged_files) -eq 0
    echo "No unstaged files"
    return 0
  end

  set -l selected_files (printf '%s\n' $unstaged_files | \
    fzf --multi \
        --prompt="Select files: " \
        --preview 'git diff --color=always {} 2>/dev/null || \
                   bat --color=always {} 2>/dev/null || \
                   cat {}')

  if test (count $selected_files) -eq 0
    return 0
  end

  echo "Selected files:"
  for file in $selected_files
    echo "  $file"
  end
  echo ""

  _confirm_operation "Add these files?"
  or return 0

  git add -- $selected_files
end
