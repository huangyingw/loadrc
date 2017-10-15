#!/bin/bash
SOURCE=$1
TARGET=$2

if [[ "${TARGET}" != *":"* ]] && [[ ! -d "${TARGET}" ]]
then
    mkdir -p "${TARGET}"
fi

rsync -aHvn --delete-during --force \
    --exclude-from="$HOME"/loadrc/bashrc/osmirror_exclude \
    "${SOURCE}/" "${TARGET}/"
