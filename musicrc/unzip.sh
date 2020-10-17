#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide the target folder ... ${NC}"
    exit 1
fi

find "$1" -type f -iname \*.zip | \
    while read ss
    do
        unzip -n -d "$(echo "$ss"|sed 's/\.zip$//g')" "$ss" && \
            rm "$ss"
    done
