#!/bin/zsh
SOURCE=$1
TARGET=$2

if [[ "${TARGET}" != *":"* ]] && [[ ! -d "${TARGET}" ]]
then
    mkdir -p "${TARGET}"
fi

rsync -aHSv --progress --force \
    "${SOURCE}" "${TARGET}" \
