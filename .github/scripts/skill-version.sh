#!/usr/bin/env bash
# Print the metadata.version of a skill, read from SKILL.md frontmatter on stdin.
# Fails if the version is missing or not MAJOR.MINOR.PATCH.
set -euo pipefail

version=$(awk '
  NR == 1 && $0 != "---" { exit }
  NR > 1 && $0 == "---" { exit }
  /^metadata:[[:space:]]*$/ { in_meta = 1; next }
  /^[^[:space:]]/ { in_meta = 0 }
  in_meta && /^[[:space:]]+version:/ {
    sub(/^[[:space:]]+version:[[:space:]]*/, "")
    gsub(/["'\''[:space:]]/, "")
    print
    exit
  }
')

if ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "metadata.version must be MAJOR.MINOR.PATCH, got '${version}'" >&2
  exit 1
fi
echo "$version"
