function fhub
  set -l repository (ghq list | fzf | cut -d "/" -f 2,3)
  if test -z "$repository"
    return 0
  end
  hub browse $repository
end
