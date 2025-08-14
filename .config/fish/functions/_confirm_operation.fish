function _confirm_operation
  set -l description $argv[1]
  set -l command $argv[2]

  if test -n "$command"
    echo "Command:"
    echo "  \$ $command"
    echo ""
  end

  while true
    read -P "$description [y/n] " -l confirm

    switch $confirm
      case y Y
        return 0
      case n N
        echo "Operation cancelled"
        return 1
      case '*'
        continue
    end
  end
end
