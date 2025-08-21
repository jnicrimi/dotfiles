function _set_commandline
  if test (count $argv) -eq 0
    echo "Error: No command provided" >&2
    return 1
  end

  commandline -r $argv
  commandline -f repaint
end
