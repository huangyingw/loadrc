#!/bin/bash -
SOURCE=$1
TARGET=$2

rsync -aHSv --progress --max-size=15m --force \
    --exclude \*.zip  \
    --exclude \*.rar  \
    "${SOURCE}" "${TARGET}" \
