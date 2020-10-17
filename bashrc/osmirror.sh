#!/bin/zsh
SOURCE=$1
TARGET=$2

if [[ "${TARGET}" != *":"* ]] && [[ ! -d "${TARGET}" ]]
then
    mkdir -p "${TARGET}"
fi

if [[ "${SOURCE}" != *":"* ]] && [[ ! -f "$SOURCE/etc/fstab" ]]
then
    echo -e "${red}please choose the correct SOURCE os folder... ${NC}"
    exit 1
fi

if [[ "${TARGET}" != *":"* ]] && [[ ! -f "$TARGET/etc/fstab" ]]
then
    echo -e "${red}please choose the correct TARGET os folder... ${NC}"
    exit 1
fi

rsync -aHSv --progress --delete-during --force \
    --exclude-from="$HOME"/loadrc/bashrc/osmirror_exclude \
    "${SOURCE}/" "${TARGET}/"
