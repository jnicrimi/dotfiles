function fz
  set -l fz_path (z -l | sort -nr | cut -d ' ' -f2- | sed -e "s/^[ \t]*//" | fzf)
  if test -z "$fz_path"
    return 0
  end
  if test -d $fz_path
    cd $fz_path
  end
end
