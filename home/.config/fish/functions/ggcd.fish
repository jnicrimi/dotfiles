function ggcd --description "Navigate to git directories"

    _assert_in_git_repository
    or return 1

    set -l git_root (git rev-parse --show-toplevel)

    set -l selected_directory (_select_git_path directory)
    or return 0

    cd "$git_root/$selected_directory"
end
