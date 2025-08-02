function ggcd

  _assert_in_git_repository
  or return 1

  set -l selected_directory (git ls-files | sed -e '/^[^\/]*$/d' -e 's/\/[^\/]*$//g' | sort | uniq | fzf --preview 'ls -la {}')

  if test -z "$selected_directory"
    echo "No directory selected"
    return 0
  end

  cd "$selected_directory"
end
