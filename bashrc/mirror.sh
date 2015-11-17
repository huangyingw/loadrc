#!/bin/bash 
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
SOURCE=$1
TARGET=$2

ready_file="${TARGET}"/"tmirror.ready"
MIRRORCHECK=$HOME/loadrc/."`hostname`".mirror.check
if [ -f ${MIRRORCHECK} ] && [ ! -f ${ready_file} ];
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
  && if [ -f ${ready_file} ];
    then
      rm ${ready_file}
    fi
