function zf --description "Select directory from zoxide database with fzf"
    set -l selected_path (zoxide query -l | fzf --prompt="Select directory: ")

    if test -z "$selected_path"
        return 0
    end

    set -l escaped_path (string escape -- $selected_path)
    _set_commandline "z $escaped_path"
end
