#!/bin/bash 
SOURCE=$1
TARGET=$2

if [ ! -d "${TARGET}" ];
then   
  mkdir -p "${TARGET}"
fi

rsync -aHinv --delete-during \
  "${SOURCE}" "${TARGET}"> find.cc
vi find.cc
