function _set_commandline
  if test (count $argv) -eq 0
    echo "Error: No command provided" >&2
    return 1
  end

  set -l cmd (string join ' ' -- $argv)
  commandline -r $cmd
  commandline -f repaint
end
