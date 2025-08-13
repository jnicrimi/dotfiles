#!/bin/bash

command -v jq >/dev/null 2>&1 || { echo "jq is required but not installed." >&2; exit 1; }
command -v terminal-notifier >/dev/null 2>&1 || { echo "terminal-notifier is required but not installed." >&2; exit 1; }

json=$(cat)

if ! echo "$json" | jq . >/dev/null 2>&1; then
    echo "Invalid JSON input" >&2
    exit 1
fi

event_name=$(echo "$json" | jq -r '.hook_event_name // "Unknown"')
cwd=$(echo "$json" | jq -r '.cwd // ""')

project_name=$(basename "$cwd")

case "$event_name" in
  "Stop")
    terminal-notifier \
      -title "Claude Code" \
      -message "🔴 $project_name" \
      -group "$project_name" \
      -sound Glass
    ;;
  "Notification")
    terminal-notifier \
      -title "Claude Code" \
      -message "🔵 $project_name" \
      -group "$project_name" \
      -sound Glass
    ;;
esac
