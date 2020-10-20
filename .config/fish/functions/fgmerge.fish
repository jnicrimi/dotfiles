function fgmerge
  set -l target_branch (git branch | fzf | sed -e "s/\* //g" | sed -e 's/^ *//' | awk "{print \$1}")
  set -l current_branch (git rev-parse --abbrev-ref HEAD)
  if test -z "$target_branch"
    return 0
  end
  set -l prompt "merge: $target_branch > $current_branch"
  echo -e $prompt
  read -P "(yes/no) " -l confirm
  if test $confirm  != "yes"
    return 0
  end
  git merge $target_branch
end
