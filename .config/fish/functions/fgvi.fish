function fgvi
  set compare_remote 0
  getopts $argv | while read -l key value
    switch $key
      case _
        printf "invalid option '%s'" $value >&2
        return 1
      case r
        set compare_remote 1
      case \*
        printf "invalid option '%s'" $key >&2
        return 1
    end
  end
  if test $compare_remote -eq 1
    set target_file (git diff --name-only --diff-filter=ACMR remotes/origin/(git_branch_name) | fzf)
    set target_path (git rev-parse --show-toplevel)"/"$target_file
  else
    set -l target_branch (git branch | fzf | sed -e "s/\* //g" | sed -e 's/^ *//' | awk "{print \$1}")
    set -l current_branch (git rev-parse --abbrev-ref HEAD)
    if test -z "$target_branch"
      return 0
    end
    set target_file (git diff --name-only --diff-filter=ACMR $target_branch..$current_branch | fzf)
    set target_path (git rev-parse --show-toplevel)"/"$target_file
  end
  if test -z "$target_path"
    return 0
  end
  if test -f $target_path
    vi $target_path
  end
end
