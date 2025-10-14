function zf --description "Select directory from zoxide database with fzf"
    set -l selected_path (zoxide query -l | fzf --prompt="Select directory: ")

    if test -z "$selected_path"
        return 0
    end

    _set_commandline "z $selected_path"
end
