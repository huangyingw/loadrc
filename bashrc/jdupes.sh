#!/bin/bash -

if [ -z "$1" ]
then
    echo -e "${red}Please provide TARGET ... ${NC}"
    exit 1
fi

if [ -z "$2" ]
then
    echo -e "${red}Please provide BACKUP ... ${NC}"
    exit 1
fi

TARGET="$1"
BACKUP="$2"
~/loadrc/bashrc/copy.sh "$TARGET" "$BACKUP" \
    && jdupes -1dNr --xsize=3M "$TARGET" \
    && jdupes -1dNr --xsize=3M "$BACKUP" \
    && ~/loadrc/bashrc/sleep.sh
