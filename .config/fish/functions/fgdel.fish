function fgdel
  set -l target_branch (git branch | fzf | sed -e "s/\* //g" | sed -e 's/^ *//' | awk "{print \$1}")
  if test -z "$target_branch"
    return 0
  end
  set -l prompt "delete: $target_branch"
  echo -e $prompt
  read -P "(yes/no) " -l confirm
  if test $confirm  != "yes"
    return 0
  end
  git branch -D $target_branch
end
