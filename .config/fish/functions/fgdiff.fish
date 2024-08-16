function fgdiff
  set stat 0
  set range 0
  getopts $argv | while read -l key value
    switch $key
      case _
        printf "invalid option '%s'" $value >&2
        return 1
      case c
        set range 1
      case s
        set stat 1
      case \*
        printf "invalid option '%s'" $key >&2
        return 1
    end
  end
  if test $range -eq 1
    set -l hash (git log --pretty=format:"%h - %an : %s" | fzf | cut -d " " -f1)
    if test -n "$hash"
      if test $stat -eq 1
        git diff --stat $hash..HEAD
      else
        git diff $hash..HEAD
      end
    end
  else
    set -l target_branch (git branch | fzf | sed -e "s/\* //g" | sed -e 's/^ *//' | awk "{print \$1}")
    set -l current_branch (git rev-parse --abbrev-ref HEAD)
    if test -z "$target_branch"
      return 0
    end
    if test $stat -eq 1
      git diff --stat $target_branch..$current_branch
    else
      git diff $target_branch..$current_branch
    end
  end
end
