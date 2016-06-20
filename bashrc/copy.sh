#!/bin/bash
SOURCE=$1
TARGET=$2

if [ ! -d "${TARGET}" ];
then   
  mkdir -p "${TARGET}"
fi

rsync -e ssh -aH --force \
  "${SOURCE}/" "${TARGET}/" \
