#!/bin/bash
SOURCE=$1
TARGET=$2

if [[ "${TARGET}" != *":"* ]] && [[ ! -d "${TARGET}" ]]
then
    mkdir -p "${TARGET}"
fi

if [ ! -f "$SOURCE/etc/fstab" ]
then
    echo -e "${red}please choose the correct SOURCE os folder... ${NC}"
fi

if [ ! -f "$TARGET/etc/fstab" ]
then
    echo -e "${red}please choose the correct TARGET os folder... ${NC}"
fi

rsync -aH --delete-during --force \
    --exclude-from="$HOME"/loadrc/bashrc/osmirror_exclude \
    "${SOURCE}/" "${TARGET}/"
