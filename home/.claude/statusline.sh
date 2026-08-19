#!/bin/bash
set -euo pipefail

IFS=$'\t' read -r model pct < <(
  jq -r '[
    (.model.display_name // "?"),
    (.context_window.used_percentage // 0 | floor)
  ] | @tsv'
)

echo "$model | ${pct}%"
