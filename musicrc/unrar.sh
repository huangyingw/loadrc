#!/bin/bash -

if [ -z "$1" ]
then
    echo -e "${red}Please provide the target folder ... ${NC}"
    exit 1
fi

find "$1" -type f -iname \*.rar | \
    while read ss \
    do ss="$(realpath "$ss")" && \
        cd "$(dirname "$ss")" && \
        unrar x -r -o- "$ss"
    done
