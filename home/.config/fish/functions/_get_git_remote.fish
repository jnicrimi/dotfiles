function _get_git_remote

    set -l branch (git branch --show-current)

    if test -z "$branch"
        echo "Error: Cannot determine branch in detached HEAD state" >&2
        return 1
    end

    set -l remote (git config --get branch.$branch.remote 2>/dev/null)

    if test -z "$remote"
        set remote (git remote | head -1)
    end

    if test -z "$remote"
        echo "Error: No remote repository configured" >&2
        return 1
    end

    echo $branch
    echo $remote
    return 0
end
