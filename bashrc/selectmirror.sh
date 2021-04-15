#!/bin/zsh 

if [ "$#" -lt 2 ]
then
  echo -e "${red}Please specify enough parameter ... ${NC}"
  exit 1
fi

SOURCE="$1"
TARGET="$2"

rsync -aHv --exclude-from="$SOURCE"/excludeFile --delete-during --force "$SOURCE"/  "$TARGET"/
