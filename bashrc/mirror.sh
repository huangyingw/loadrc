#!/bin/bash 
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
SOURCE=$1
TARGET=$2

ready_file="tmirror.ready"
if [ ! -f ${ready_file} ];
then
  echo -e "${red}tmirror must be run before mirror ... ${NC}"
  exit 1
fi
if [ ! -d "${TARGET}" ];
then   
  mkdir -p "${TARGET}"
fi

rsync -aH --delete-during --force \
  "${SOURCE}" "${TARGET}" \
  && rm ${ready_file}
