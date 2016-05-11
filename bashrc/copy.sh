#!/bin/bash
SOURCE=$1
TARGET=$2

SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
. "$SCRIPTPATH"/getConDetails.sh "mini:/media/volgrp"

echo $user
echo $host
echo $folder

. "$SCRIPTPATH"/getConDetails.sh "huangyingw@mini:/media/volgrp"

echo
echo $user
echo $host
echo $folder

if [[ $SOURCE == *":"* ]]
then
  DOMAIN=root@"$SOURCE"
  DOMAIN=root@"$SOURCE"
fi

#if [ ! -d "${TARGET}" ];
#then   
#  mkdir -p "${TARGET}"
#fi
#
#rsync -aH --force \
  #  "${SOURCE}/" "${TARGET}/" \
