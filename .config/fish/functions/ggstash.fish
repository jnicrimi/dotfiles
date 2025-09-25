function ggstash --description "Manage git stashes"

    _assert_in_git_repository
    or return 1

    set -l has_changes (git status --porcelain)

    set -l stash_list (git stash list --format="%gd: %s" | string split \n)
    set -l has_stashes (test (count $stash_list) -gt 0; and echo "yes"; or echo "no")

    set -l menu_options

    if test -n "$has_changes"
        set menu_options $menu_options stash
    end

    if test "$has_stashes" = yes
        set menu_options $menu_options pop drop
    end

    if test (count $menu_options) -eq 0
        echo "No changes to stash and no stashes available"
        return 0
    end

    set -l selected (_select_menu "Stash operation" $menu_options)
    or return 0

    switch $selected
        case stash
            set -l changed_files (git status --porcelain | sed 's/^...//')

            echo "Changed files:"
            for file in $changed_files
                echo "  $file"
            end

            read -P "Stash message: " -l stash_message

            if test -z "$stash_message"
                echo "Error: No stash message entered" >&2
                return 1
            end

            _set_commandline "git stash push -m \"$stash_message\""

        case pop
            if test (count $stash_list) -eq 0
                echo "No stashes found"
                return 0
            end

            set -l selected_stash (printf '%s\n' $stash_list | \
                fzf --prompt="Select stash to pop: " \
                    --preview 'echo {} | cut -d":" -f1 | xargs git stash show -p --color=always')

            if test -z "$selected_stash"
                return 0
            end

            set -l stash_id (echo $selected_stash | cut -d":" -f1)

            echo "Selected stash:"
            echo "  $selected_stash"

            _set_commandline "git stash pop $stash_id"

        case drop
            if test (count $stash_list) -eq 0
                echo "No stashes found"
                return 0
            end

            set -l selected_stash (printf '%s\n' $stash_list | \
                fzf --prompt="Select stash to drop: " \
                    --preview 'echo {} | cut -d":" -f1 | xargs git stash show -p --color=always')

            if test -z "$selected_stash"
                return 0
            end

            set -l stash_id (echo $selected_stash | cut -d":" -f1)

            echo "Selected stash:"
            echo "  $selected_stash"

            _set_commandline "git stash drop $stash_id"
    end
end
