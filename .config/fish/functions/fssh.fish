function fssh
  set -l ssh_host (cat ~/.ssh/config | grep -i \^host | awk '{print $2}' | fzf)
  if test -n "$ssh_host"
    ssh $ssh_host
  end
end
