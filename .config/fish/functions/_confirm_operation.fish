function _confirm_operation

  set -l prompt_message "[y/N] "
  if test (count $argv) -gt 0
    set prompt_message "$argv[1] [y/N] "
  end

  read -P "$prompt_message" -l confirm

  if test "$confirm" != y -a "$confirm" != Y
    echo "Operation cancelled"
    return 1
  end

  return 0
end
