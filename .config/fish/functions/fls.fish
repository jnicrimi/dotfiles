function fls
  set fullpath 0
  getopts $argv | while read -l key value
    switch $key
      case _
        printf "invalid option '%s'" $value >&2
        return 1
      case a
        set fullpath 1
      case \*
        printf "invalid option '%s'" $key >&2
        return 1
    end
  end
  set target_file (fd -t f | fzf)
  if test -z "$target_file"
    return 0;
  end
  if test $fullpath -eq 1
    echo (pwd)"/"$target_file
  else
    echo $target_file
  end
end
