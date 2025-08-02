function fgdiff
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  argparse -n fgdiff 's/stat' -- $argv
  or return 1
  set -l target_branch (git branch | fzf | sed -e "s/\* //g" | sed -e 's/^ *//' | awk "{print \$1}")
  set -l current_branch (git rev-parse --abbrev-ref HEAD)
  if test -z "$target_branch"
    return 0
  end
  if set -lq _flag_stat
    git diff --stat $target_branch..$current_branch
  else
    git diff $target_branch..$current_branch
  end
end
