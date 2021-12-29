#!/bin/zsh

if [ -z "$1" ] || [ -z "$2" ]
then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

source=$1
target=$2

ready_file="$source"/"tmirror.ready"
MIRRORCHECK=$HOME/loadrc/."`hostname`".mirror.check

if [[ "${ready_file}" != *":"* ]] && [[ ! -f ${ready_file} ]]
then
    echo -e "${red}tmirror must be run before mirror ... ${NC}"
    exit 1
fi

if [ -z "$source" ]
then
    echo -e "${red}source could not be none... ${NC}"
    exit 1
fi

if [ -z "$target" ]
then
    echo -e "${red}target could not be none... ${NC}"
    exit 1
fi

if [[ "$target" != *":"* ]] && [[ ! -d "$target" ]]
then
    mkdir -p "$target"
fi

rm "$ready_file"

siconv=$(~/loadrc/bashrc/get_iconv.sh "$source")
ticonv=$(~/loadrc/bashrc/get_iconv.sh "$target")

rsync -aHSv --progress --delete-before --force \
    --iconv="$ticonv,$siconv" \
    "$source/" "$target/" && \
    if [ -f "${MIRRORCHECK}" ] ; \
    then \
        ~/loadrc/bashrc/sleep.sh ; \
    fi
