#!/bin/bash -
SOURCE=$1
TARGET=$2

rsync -aHSv --progress --max-size=15m --delete-before --force \
    --exclude \*.zip  \
    --exclude \*.rar  \
    "${SOURCE}" "${TARGET}" \
