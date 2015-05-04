#!/bin/bash
SOURCE=$1
TARGET=$2
FILE_TYPE=$HOME/bashrc/file_type
command_params=`cat ${FILE_TYPE}|{ read suf; echo -n "--include=*.$suf";while read suf;do echo -n " --include=*.$suf";done; }`

if [ "$SOURCE" != "$TARGET" ]
then
  if [ ! -d "$TARGET" ];
  then   
    mkdir -p "$TARGET"
  fi
  rsync -avH --include=*/  $command_params --exclude=* --prune-empty-dirs "$SOURCE" "$TARGET"
else
  echo "please choose the different dir!"
fi
