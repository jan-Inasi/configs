#!/usr/bin/env bash

set -euo pipefail

TMUX_CONF_FILE_NAME=".tmux.conf"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TMUX_CONF_SOURCE_PATH="${SCRIPT_DIR}/${TMUX_CONF_FILE_NAME}"
TMUX_CONF_DESTINATION_PATH="${HOME}/${TMUX_CONF_FILE_NAME}"

# check if the source config exists
if [[ ! -f "${TMUX_CONF_SOURCE_PATH}" ]]; then
    echo "The reference tmux conf file has not been found"\
         "where it was expected i.e. ${TMUX_CONF_SOURCE_PATH}" >&2
    exit 1
fi

if [[ -e "${TMUX_CONF_DESTINATION_PATH}" ]]; then

    if [[ -d "${TMUX_CONF_DESTINATION_PATH}" ]]; then
        echo "There's a dir at the tmux conf destination path"\
             "(${TMUX_CONF_DESTINATION_PATH})" >&2
        exit 1
    fi

    if [[ ! -w "${TMUX_CONF_DESTINATION_PATH}" ]]; then
        echo "You don't have the write permissions to write at the"\
             "tmux conf destination file at: '${TMUX_CONF_DESTINATION_PATH}'" >&2
        exit 1
    fi

    if [[ ! -r "${TMUX_CONF_DESTINATION_PATH}" ]]; then
        echo "You don't have the read permissions at the"\
             "tmux conf destination file at: '${TMUX_CONF_DESTINATION_PATH}'" >&2
        exit 1
    fi
else # there's no file nor dir at the tmux destination path

    dest_dir="$(dirname "${TMUX_CONF_DESTINATION_PATH}")"

    if [[ ! -w "${dest_dir}" || ! -x "${dest_dir}" ]]; then
        echo "We can't create a file at the tmux conf destination dir"\
             "(${dest_dir})" >&2
        exit 1
    fi
fi

if cmp -s "${TMUX_CONF_SOURCE_PATH}" "${TMUX_CONF_DESTINATION_PATH}"; then
    echo "The current config is already applied"
    exit 0
fi

read -rp "Overwrite? [y/N]: " answer

if [[ ! "${answer}" =~ ^[Yy]$ ]]; then
    echo "The current config left unchanged at: '${TMUX_CONF_DESTINATION_PATH}'"
    exit 0
fi

if cp "${TMUX_CONF_SOURCE_PATH}" "${TMUX_CONF_DESTINATION_PATH}"; then
    echo "Config applied successfully at '${TMUX_CONF_DESTINATION_PATH}'"
    exit 0
else
    echo "Failed to apply the config to '${TMUX_CONF_DESTINATION_PATH}'" >&2
    exit 1
fi
