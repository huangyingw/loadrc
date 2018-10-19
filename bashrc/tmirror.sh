#!/bin/bash
SOURCE=$1
TARGET=$2

ready_file="${TARGET}"/"tmirror.ready"
if [ ! -d "${TARGET}" ]
then
    mkdir -p "${TARGET}"
fi

rsync -aHinv --delete-before --force \
    "${SOURCE}" "${TARGET}"> ${ready_file}
nvim ${ready_file}
