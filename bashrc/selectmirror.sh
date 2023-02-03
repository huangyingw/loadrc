#!/bin/zsh

if [ "$#" -lt 2 ]
then
  echo -e "${red}Please specify enough parameter ... ${NC}"
  exit 1
fi

SOURCE="$1"
TARGET="$2"

ready_file="$SOURCE/tselectmirror.ready"

if [ ! -f ${ready_file} ]
then
    echo -e "${red}tmirror must be run before mirror ... ${NC}"
    exit 1
fi

rsync -aHv --exclude-from="$SOURCE"/excludeFile --delete-during --force "$SOURCE"/  "$TARGET"/
