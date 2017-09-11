#!/bin/bash
SOURCE=$1
TARGET=$2

if [ -L ${1%/} ] || [ -L ${2%/} ]
then
    echo -e "${red}please not use simbo link ! ... ${NC}"
    exit 1
fi

LNSOURCE=`echo $SOURCE | sed 's/\/$//'`

~/loadrc/bashrc/move.sh "$SOURCE" "$TARGET"
ln -fs "$TARGET" "$LNSOURCE"
