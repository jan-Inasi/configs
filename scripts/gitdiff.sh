#!/usr/bin/env bash
set -euo pipefail

# check that git is installed
command -v git >/dev/null || { echo "git is not installed"; exit 1; }

# check that the source file exists
[[ -f "$1" ]] || { echo "I can't find the source file at $1"; exit 1; }

# check that the target file exists
[[ -f "$2" ]] || { echo "I can't find the target file at $2"; exit 1; }

status=0

git diff --no-index "$1" "$2" || status=$?

# git diff exits 1 when the files simply differ
# that's the expected result of running a diff, not a failure

case $status in
    0) echo "files are the same" ;;
    1) exit 0 ;;
    *) exit "$status" ;;
esac
