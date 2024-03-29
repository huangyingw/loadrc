#!/bin/zsh

if [ -z "$1" ] || [ -z "$2" ]
then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

SOURCE=$1
TARGET=$2

ready_file="$SOURCE"/"tmirror.ready"
MIRRORCHECK=$HOME/loadrc/."`hostname`".mirror.check

if [[ "${ready_file}" != *":"* ]] && [[ ! -f ${ready_file} ]]
then
    echo -e "${red}tmirror must be run before mirror ... ${NC}"
    exit 1
fi

if [ -z "$SOURCE" ]
then
    echo -e "${red}SOURCE could not be none... ${NC}"
    exit 1
fi

if [ -z "$TARGET" ]
then
    echo -e "${red}TARGET could not be none... ${NC}"
    exit 1
fi

if [[ "${TARGET}" != *":"* ]] && [[ ! -d "${TARGET}" ]]
then
    mkdir -p "${TARGET}"
fi

rm "$ready_file"
rsync -aHSv --progress --delete-before --force \
    "${SOURCE}/" "${TARGET}/" && \
    if [ -f "${MIRRORCHECK}" ] ; \
    then \
        ~/loadrc/bashrc/sleep.sh ; \
    fi
