function ggcommit --description "Create conventional commit"

  _assert_in_git_repository
  or return 1

  set -l commit_types "feat" "fix" "refactor" "chore" "docs" "test" "style" "build" "ci" "perf" "revert"
  set -l type (_select_menu "Commit type" $commit_types)
  or return 0

  read -P "Enter commit message: " message
  or return 0

  if test -z "$message"
    echo "Error: No commit message entered" >&2
    return 1
  end

  if string match -qr '["\\\]' -- "$message"
    echo "Error: Commit message contains invalid characters" >&2
    return 1
  end

  set -l commit_option (_select_menu "Commit option" "commit" "commit --no-verify")
  or return 0

  set -l commit_command "git commit -m \"$type: $message\""
  if test "$commit_option" = "commit --no-verify"
    set commit_command "git commit --no-verify -m \"$type: $message\""
  end

  _confirm_operation "Create commit" "$commit_command"
  or return 0

  if test "$commit_option" = "commit --no-verify"
    git commit --no-verify -m "$type: $message"
  else
    git commit -m "$type: $message"
  end
end
