function _get_git_remote

    set -l branch (git rev-parse --abbrev-ref HEAD)
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
