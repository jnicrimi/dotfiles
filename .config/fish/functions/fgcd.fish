function fgcd
  set -l target_directory (git ls-files | sed -e '/^[^\/]*$/d' -e 's/\/[^\/]*$//g' | sort | uniq | fzf -e)
  if test -z "$target_directory"
    return 0
  end
  cd $target_directory
end
