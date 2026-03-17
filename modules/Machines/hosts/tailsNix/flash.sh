#!/usr/bin/env bash

RUN_DIR="$(pwd)"
DIR="$(dirname ${BASH_SOURCE})"

ISO=""

cd "${DIR}"
ISO="$(find -L . -type f -name '*.iso')"

sudo dd if="${ISO}" of="$1" bs=4M status=progress oflag=sync

cd "${RUN_DIR}"
