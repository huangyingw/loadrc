#!/bin/zsh
SOURCE=$1
TARGET=$2

if [ ! -d "${TARGET}" ]
then
    mkdir -p "${TARGET}"
fi

rsync -aHinv \
    "${SOURCE}" "${TARGET}"> find.findresult
nvim find.findresult
