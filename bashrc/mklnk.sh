#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
SOURCE=$1
TARGET=$2

if [ -L ${1%/} ] || [ -L ${2%/} ]
then
  echo -e "${red}please not use simbo link ! ... ${NC}"
  exit 1
fi

LNSOURCE=`echo $SOURCE | sed 's/\/$//'`

~/loadrc/bashrc/move.sh "$SOURCE" "$TARGET" \
  && ln -s "$TARGET" "$LNSOURCE" 
