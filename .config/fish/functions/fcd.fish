function fcd
  set -l target_directory (fd -t d -H -E .git | fzf)
  if test -z "$target_directory"
    return 0
  end
  cd $target_directory
end
