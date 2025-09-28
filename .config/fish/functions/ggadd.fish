function ggadd --description "Add unstaged files interactively with fzf"

    _assert_in_git_repository
    or return 1

    set -l git_root (git rev-parse --show-toplevel)

    set -l modified_files (git diff --name-only --diff-filter=AMRT)
    set -l deleted_files (git diff --name-only --diff-filter=D --no-renames)
    set -l untracked_files (git ls-files --others --exclude-standard)

    set -l unstaged_files
    test -n "$modified_files" && set -a unstaged_files $modified_files
    test -n "$deleted_files" && set -a unstaged_files $deleted_files
    test -n "$untracked_files" && set -a unstaged_files $untracked_files

    if test (count $unstaged_files) -eq 0
        echo "No unstaged files"
        return 0
    end

    set -l selected_files (printf '%s\n' $unstaged_files | \
        fzf --multi --prompt="Select files: ")

    if test (count $selected_files) -eq 0
        return 0
    end

    echo "Selected files:"
    for file in $selected_files
        echo "  $file"
    end

    set -l escaped_files
    for file in $selected_files
        set -a escaped_files (string escape -- $file)
    end
    _set_commandline "git -C $git_root add -- $escaped_files"
end
