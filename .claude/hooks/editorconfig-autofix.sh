#!/bin/bash

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')

if [ -n "$file_path" ] && [ -f "$file_path" ]; then
  if ! editorconfig-checker "$file_path" >/dev/null 2>&1; then
    echo "EditorConfig violations found in $file_path" >&2
    editorconfig-checker "$file_path" 2>&1 | head -20 >&2
    exit 2
  fi
fi
