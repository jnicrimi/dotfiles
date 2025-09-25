function ggcd --description "Navigate to git directories"

    _assert_in_git_repository
    or return 1

    set -l git_root (git rev-parse --show-toplevel)

    pushd $git_root >/dev/null
    set -l selected_directory (git ls-files | \
      sed -e '/^[^\/]*$/d' -e 's/\/[^\/]*$//g' | \
      sort | uniq | \
      fzf --prompt="Directory: ")
    popd >/dev/null

    if test -z "$selected_directory"
        return 0
    end

    cd "$git_root/$selected_directory"
end
