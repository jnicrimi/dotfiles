function _select_menu
  if test (count $argv) -lt 2
    return 1
  end

  set -l prompt $argv[1]
  set -l options $argv[2..-1]

  printf '%s\n' $options | fzf --prompt="$prompt: "
end
