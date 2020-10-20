function fgadd
  set -l target_files (git diff --name-only | fzf -m)
  if test -z "$target_files"
    return 0
  end
  set -l gitroot (git rev-parse --show-toplevel)
  set -l absolute_path
  for target_file in $target_files
    set absolute_path $gitroot"/"$target_file
    if test -f $absolute_path
      git add $absolute_path
    end
  end
end
