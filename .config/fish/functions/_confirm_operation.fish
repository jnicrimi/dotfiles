function _confirm_operation
  set -l description $argv[1]
  set -l command $argv[2]

  if test -n "$command"
    echo "Command:"
    echo "  \$ $command"
    echo ""
  end

  read -P "$description [y/N] " -l confirm

  if test "$confirm" != y -a "$confirm" != Y
    echo "Operation cancelled"
    return 1
  end

  return 0
end
