#!/usr/bin/env bash

set -euo pipefail


SOURCE_PATH="$1"
TARGET_PATH="$2"

# check if the source config exists
if [[ ! -f "${SOURCE_PATH}" ]]; then
    echo "The source confing file has not been found"\
         "where it was expected i.e. ${SOURCE_PATH}" >&2
    exit 1
fi

if [[ -e "${TARGET_PATH}" ]]; then

    if [[ -d "${TARGET_PATH}" ]]; then
        echo "There's a dir at the target path (${TARGET_PATH})" >&2
        exit 1
    fi

    if [[ ! -w "${TARGET_PATH}" ]]; then
        echo "You are not permited to write at the"\
             "conf target path at: '${TARGET_PATH}'" >&2
        exit 1
    fi

    if [[ ! -r "${TARGET_PATH}" ]]; then
        echo "You are not permited to read the"\
             "conf target path at: '${TARGET_PATH}'" >&2
        exit 1
    fi
else # there's no file nor dir at the tmux destination path

    dest_dir="$(dirname "${TARGET_PATH}")"

    if [[ ! -w "${dest_dir}" || ! -x "${dest_dir}" ]]; then
        echo "We can't create a file at the conf target dir"\
             "(${dest_dir})" >&2
        exit 1
    fi

    if cp "${SOURCE_PATH}" "${TARGET_PATH}"; then
        echo "Config applied successfully at '${TARGET_PATH}'"
        exit 0
    else
        echo "Failed to apply the config to '${TARGET_PATH}'" >&2
        exit 1
    fi
fi

if cmp -s "${SOURCE_PATH}" "${TARGET_PATH}"; then
    echo "The current config is already applied"
    exit 0
fi

read -rp "Overwrite? [y/N]: " answer

if [[ ! "${answer}" =~ ^[Yy]$ ]]; then
    echo "The current config left unchanged at: '${TARGET_PATH}'"
    exit 0
fi

if cp "${SOURCE_PATH}" "${TARGET_PATH}"; then
    echo "Config applied successfully at '${TARGET_PATH}'"
    exit 0
else
    echo "Failed to apply the config to '${TARGET_PATH}'" >&2
    exit 1
fi
