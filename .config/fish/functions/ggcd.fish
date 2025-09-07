function ggcd --description "Navigate to git directories"

  _assert_in_git_repository
  or return 1

  set -l git_root (git rev-parse --show-toplevel)

  set -l selected_directory (cd $git_root && git ls-files | \
      sed -e '/^[^\/]*$/d' -e 's/\/[^\/]*$//g' | \
      sort | uniq | \
      fzf --prompt="Directory: ")

  if test -z "$selected_directory"
    return 0
  end

  cd "$git_root/$selected_directory"
end
