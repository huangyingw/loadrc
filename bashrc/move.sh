#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color

if [ ! -d "$2" ];
then   
  mkdir -p "$2"
fi

SOURCE=`realpath "$1"`
TARGET=`realpath "$2"`

if [ "$SOURCE" != "$TARGET" ]
then
  rsync --remove-source-files -aH --force "$1" "$2" \
    && ~/loadrc/bashrc/rmEmpty.sh "$1"
else
  echo -e "${red}same dir --> ${SOURCE} ... ${NC}"
  echo -e "${red}please choose the different dir! ... ${NC}"
  exit 1
fi
