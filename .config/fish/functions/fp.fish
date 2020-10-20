function fp
  set -l insensitive
  set -l number
  set -l pattern
  set -l type
  getopts $argv | while read -l key value
    switch $key
      case _
        if test -n "$pattern"
          echo "duplicate definition <pattern>" >&2
          return 1
        end
        set pattern $value
      case h
        echo "Usage:"
        echo "  fp [-h] [-i] [-n number] [-t type] pattern"
        echo "    -h : Show help"
        echo "    -i : Case insensitive search"
        echo "    -n : Set line number"
        echo "    -t : Set file extension"
        return 0
      case i
        if test -n "$insensitive"
          printf "duplicate definition '%s'" $key >&2
          return 1
        end
        set insensitive 1
      case n
        if test -n "$number"
          printf "duplicate definition '%s'" $key >&2
          return 1
        end
        set number $value
      case t
        if test -n "$type"
          printf "duplicate definition '%s'" $key >&2
          return 1
        end
        set type $value
      case \*
        printf "invalid option '%s'" $key >&2
        return 1
    end
  end
  if test -z "$pattern"
    echo "<pattern> is blank" >&2
    return 1
  end
  if test -z "$number"
    set number 0
  end
  set -l search "-s"
  if test -n "$insensitive"
    set search "-i"
  end
  if test -n "$type"
    rg -F -B $number -A $number --hidden -t $type $search $pattern
  else
    rg -F -B $number -A $number --hidden $search $pattern
  end
end
