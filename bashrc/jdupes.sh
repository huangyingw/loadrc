#!/bin/bash -

if [ -z "$1" ]
then
    echo -e "${red}Please provide parameter ... ${NC}"
    exit 1
fi

TARGET="$1"
jdupes -1dNr --xsize=300M "$TARGET"
