function ggdiff --description "Show git differences"

    _assert_in_git_repository
    or return 1

    set -l selected_branch (_select_other_branch)
    or return 0
    set -l current_branch (git branch --show-current)

    if test -z "$current_branch"
        echo "Error: Cannot show diff in detached HEAD state" >&2
        return 1
    end

    set -l action (_select_menu "Action" "diff" "stat" "edit")
    or return 0

    set -l diff_options
    if test "$action" != edit
        set diff_options (_select_menu "Options" "空白・空行無視" "指定なし")
        or return 0
    end

    switch "$action"
        case diff
            switch "$diff_options"
                case "空白・空行無視"
                    _set_commandline "git diff --ignore-all-space --ignore-blank-lines $selected_branch..$current_branch"
                case 指定なし
                    _set_commandline "git diff $selected_branch..$current_branch"
            end
        case stat
            switch "$diff_options"
                case "空白・空行無視"
                    _set_commandline "git diff --stat --ignore-all-space --ignore-blank-lines $selected_branch..$current_branch"
                case 指定なし
                    _set_commandline "git diff --stat $selected_branch..$current_branch"
            end
        case edit
            set -l root (git rev-parse --show-toplevel)
            set -l files (git diff --name-only "$selected_branch..$current_branch" | \
                fzf --multi --prompt="Select files: ")

            if test -n "$files"
                set -l escaped_files
                for file in $files
                    set -a escaped_files (string escape -- "$root/$file")
                end
                _set_commandline "vim $escaped_files"
            end
        case '*'
            return 0
    end
end
