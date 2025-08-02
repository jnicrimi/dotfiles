function fghq
  set -l repository (ghq list | fzf)
  if test -z "$repository"
    return 0
  end
  set -l repository_full_path (ghq list --full-path --exact "$repository")
  if test -z "$repository_full_path"
    echo "Error: Failed to get repository path" >&2
    return 1
  end
  cd "$repository_full_path"
end
