#!/bin/zsh
SOURCE=$1
TARGET=$2

if [ ! -d "${TARGET}" ]
then
    mkdir -p "${TARGET}"
fi

rsync -aH --delete-after \
"${SOURCE}" "${TARGET}"
