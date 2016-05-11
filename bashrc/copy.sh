#!/bin/bash
SOURCE=$1
TARGET=$2

. ~/loadrc/bashrc/getConDetails.sh "mini:/media/volgrp"

echo $user
echo $host
echo $folder

. ~/loadrc/bashrc/getConDetails.sh "huangyingw@mini:/media/volgrp"

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
