function _select_git_path

    set -l path_type $argv[1]
    set -l git_root (git rev-parse --show-toplevel)
    set -l selected

    pushd $git_root >/dev/null
    switch "$path_type"
        case directory
            set selected (git ls-files | \
                sed -e '/^[^\/]*$/d' -e 's/\/[^\/]*$//g' | \
                sort | uniq | \
                fzf --prompt="Directory: ")
        case file
            set selected (git ls-files | fzf --prompt="File: ")
    end
    popd >/dev/null

    if test -z "$selected"
        return 1
    end

    echo $selected
    return 0
end
