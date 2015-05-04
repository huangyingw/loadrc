#!/bin/bash
returnstring=""
function IsSlash()
{
  var=$1
  case $var in
    */)
      returnstring=$var 
      ;;
    *)
      returnstring=$var"/"
      ;;
  esac
}
IsSlash "$1"
SOURCE=$returnstring
IsSlash "$2"
TARGET=$returnstring

if [ "$SOURCE" != "$TARGET" ]
then
  if [ ! -d "$TARGET" ];
  then   
    mkdir -p "$TARGET"
  fi

  rsync -aHinv \
    "${SOURCE}" "${TARGET}"> find.cc
else
  echo "please choose the different dir!"
fi
