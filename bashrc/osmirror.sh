#!/bin/bash
SOURCE=$1
TARGET=$2

if [[ "${TARGET}" != *":"* ]] && [[ ! -d "${TARGET}" ]]
then
    mkdir -p "${TARGET}"
fi

rsync -aHvn --delete-during --force \
    "${SOURCE}/" "${TARGET}/"
