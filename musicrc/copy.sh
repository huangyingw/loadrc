#!/bin/bash -
SOURCE=$1
TARGET=$2

rsync -aHv --progress --max-size=400m --force \
    --exclude \*.zip  \
    --exclude \*.rar  \
    "${SOURCE}" "${TARGET}" \
