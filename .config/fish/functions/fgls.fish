function fgls
  set staged 0
  set verbose 0
  getopts $argv | while read -l key value
    switch $key
      case _
        printf "invalid option '%s'" $value >&2
        return 1
      case s
        set staged 1
      case v
        set verbose 1
      case \*
        printf "invalid option '%s'" $key >&2
        return 1
    end
  end
  if test $staged -eq 1
    set target_file (git diff --cached --name-only --diff-filter=ACMR | fzf)
    set target_path (git rev-parse --show-toplevel)"/"$target_file
  else
    set target_path (pwd)"/"(git ls-files | fzf)
  end
  if test -z "$target_path"
    return 0
  end
  if test -f "$target_path"
    if test $verbose -eq 1
      echo $target_path
    else
      vi $target_path
    end
  end
end
