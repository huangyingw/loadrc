#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide the target folder ... ${NC}"
    exit 1
fi

find "$1" -type f -iname \*.rar | \
    while read ss
    do
        ss="$(realpath "$ss")" && \
            cd "$(dirname "$ss")" && \
            unrar x -r -pwww.pt80.net -o+ "$ss" && rm "$ss" ; \
            unrar x -r -photnrg -o+ "$ss" && rm "$ss" ; \
            unrar x -r -pwww.zasv.com-联动印象 -o+ "$ss" && rm "$ss" ; \
            unrar x -r -pwww.zasv.com -o+ "$ss" && rm "$ss" ; \
            unrar x -r -p联动印象 -o+ "$ss" && rm "$ss" ; \
            unrar x -r -pUploadByK@TSDM.NET -o+ "$ss" && rm "$ss" ; \
    done
