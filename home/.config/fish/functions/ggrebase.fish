function ggrebase --description "Interactive rebase"

    _assert_in_git_repository
    or return 1

    set -l commit_hash (_select_commit)
    or return 0

    if git rev-parse --verify --quiet "$commit_hash^" >/dev/null 2>&1
        _set_commandline "git rebase -i $commit_hash^"
    else
        echo "Selected commit has no parent – nothing to rebase" >&2
        return 1
    end
end
