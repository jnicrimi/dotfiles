function _confirm_operation
  set -l description $argv[1]
  set -l command $argv[2]

  if test -n "$command"
    echo "$description"
    echo "  \$ $command"
    echo ""
  else
    echo "$argv[1]"
  end

  read -P "[y/N] " -l confirm

  if test "$confirm" != y -a "$confirm" != Y
    echo "Operation cancelled"
    return 1
  end

  return 0
end
