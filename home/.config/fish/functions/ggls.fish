function ggls --description "Select tracked files and set absolute paths to prompt"

    _assert_in_git_repository
    or return 1

    set -l root (git rev-parse --show-toplevel)

    set -l files (git -C $root ls-files | \
        fzf --multi --prompt="Select files: ")

    if test -n "$files"
        set -l escaped_files
        for file in $files
            set -a escaped_files (string escape -- "$root/$file")
        end
        _set_commandline "$escaped_files"
        commandline -C 0
        commandline -f repaint
    end
end
