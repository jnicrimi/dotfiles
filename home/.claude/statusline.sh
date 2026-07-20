#!/bin/bash

IFS=$'\t' read -r model cwd pct < <(
  jq -r '[
    (.model.display_name // "?"),
    (.workspace.current_dir // .cwd // "."),
    (.context_window.used_percentage // 0 | floor)
  ] | @tsv'
)

branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
[ -z "$branch" ] && branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null)

echo "${cwd##*/} | ${branch:--} | $model | ${pct}%"
