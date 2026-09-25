#!/usr/bin/env bash
set -euo pipefail

# check that git is installed
command -v git >/dev/null || { echo "git is not installed"; exit 1; }

# check that the source file exists
[[ -f "$1" ]] || { echo "I can't find the source file at $1"; exit 1; }

# check that the target file exists
[[ -f "$2" ]] || { echo "I can't find the target file at $2"; exit 1; }

git diff --no-index "$1" "$2" || {
    status=$?
    # git diff exits 1 when the files simply differ
    # that's the expected result of running a diff, not a failure
    (( status == 1 )) || exit "$status"
}
