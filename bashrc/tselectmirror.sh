#!/bin/zsh

if [ "$#" -lt 2 ]
then
  echo -e "${red}Please specify enough parameter ... ${NC}"
  exit 1
fi

SOURCE="$1"
TARGET="$2"
ready_file="$SOURCE/tselectmirror.ready"

rsync -aHvn --exclude-from="$SOURCE"/excludeFile --delete-during --force "$SOURCE"/  "$TARGET"/  > "$ready_file"
