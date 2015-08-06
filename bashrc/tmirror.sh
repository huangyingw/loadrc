#!/bin/bash 
SOURCE=$1
TARGET=$2

ready_file="${TARGET}"/"tmirror.ready"
if [ ! -d "${TARGET}" ];
then   
  mkdir -p "${TARGET}"
fi

rsync -aHinv --delete-during --force \
  "${SOURCE}" "${TARGET}"> ${ready_file}
vi ${ready_file}
