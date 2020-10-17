#!/bin/zsh

if [ -z "$1" ] || [ -z "$2" ]
then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

SOURCE=$1
TARGET=$2

if [[ "${TARGET}" != *":"* ]] && [[ ! -d "${TARGET}" ]]
then
    mkdir -p "${TARGET}"
fi

rsync -aHSv --progress --force --ignore-existing \
    "${SOURCE}" "${TARGET}"
