#!/bin/bash

command -v jq >/dev/null 2>&1 || { echo "jq is required but not installed." >&2; exit 1; }

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
    afplay /System/Library/Sounds/Glass.aiff &
    osascript -e "display notification \"🔴 $project_name\" with title \"Claude Code\""
    ;;
  "Notification")
    afplay /System/Library/Sounds/Glass.aiff &
    osascript -e "display notification \"🔵 $project_name\" with title \"Claude Code\""
    ;;
esac
