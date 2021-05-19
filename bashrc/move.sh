#!/bin/zsh

if [ -z "$1" ] || [ -z "$2" ]
then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

if [[ "$2" != *":"* ]] && [[ ! -d "$2" ]]
then
    mkdir -p "$2"
fi

SOURCE="$1"
realpath "$1" && SOURCE=$(realpath "$1")

TARGET="$2"
realpath "$2" && TARGET=$(realpath "$2")

if [ -n "$SOURCE" ] && [ -n "$TARGET" ] && [ "$SOURCE" != "$TARGET" ]
then
    rsync --remove-source-files -aHSv --progress --force "$SOURCE/" "$TARGET/" ; \
        ~/loadrc/bashrc/rmEmpty.sh "$SOURCE/"
else
    echo -e "${red}same dir --> ${SOURCE} ... ${NC}"
    echo -e "${red}please choose the different dir! ... ${NC}"
    exit 1
fi
