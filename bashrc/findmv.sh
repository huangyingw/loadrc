#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide the SOURCE... ${NC}"
    exit 1
fi

if [ -z "$2" ]
then
    echo -e "${red}Please provide the TARGET... ${NC}"
    exit 1
fi

SOURCE="$1"
TARGET="$2"


find "$SOURCE" -type f | \
    while read ss
    do
        new_ss=$(echo "$ss" | sed -e "s#$SOURCE#$TARGET#g")
        mkdir -p "$(dirname "$new_ss")"
        mv -nv "$ss" "$new_ss"
    done

~/loadrc/bashrc/move.sh "$SOURCE" "$TARGET"
