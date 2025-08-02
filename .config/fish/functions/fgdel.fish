function fgdel
  if not git rev-parse --git-dir >/dev/null 2>&1
    echo "Error: Not in a git repository" >&2
    return 1
  end
  set -l target_branch (git branch --format="%(refname:short)" | fzf)
  if test -z "$target_branch"
    return 0
  end
  set -l prompt "delete: $target_branch"
  echo "$prompt"
  read -P "(yes/no) " -l confirm
  if test "$confirm" != "yes"
    return 0
  end
  git branch -D "$target_branch"
end
