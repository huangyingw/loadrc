#!/bin/bash
#SOURCE=$1
#TARGET=$2

SOURCE=$(~/loadrc/bashrc/wrapConStr.sh "mini:/media/volgrp/timemachine/")
TARGET="/media/volgrp/timemachine/" 

#if [ ! -d "${TARGET}" ];
#then   
#  mkdir -p "${TARGET}"
#fi

echo rsync -aH --force \
  "${SOURCE}/" "${TARGET}/" \
