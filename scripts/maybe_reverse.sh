#!/usr/bin/env bash

set -euo pipefail

reversed=false
args=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--reverse) reversed=true; shift ;;
        --) shift; args+=("$@"); break ;;
        -*) echo "unknown flag: $1" >&2; exit 2 ;;
        *) args+=("$1"); shift ;;
    esac
done

if (( ${#args[@]} != 3 )); then
    echo "expected 3 args, got ${#args[@]}" >&2
    exit 1
fi

if [[ "$reversed" == "true" ]]; then
    "${args[0]}" "${args[2]}" "${args[1]}"
else
    "${args[0]}" "${args[1]}" "${args[2]}"
fi
