function fcd
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l selected_directory (git ls-files | sed -e '/^[^\/]*$/d' -e 's/\/[^\/]*$//g' | sort | uniq | fzf)
  if test -z "$selected_directory"
    echo "No directory selected"
    return 0
  end
  cd "$selected_directory"
end
