#!/bin/bash
SOURCE=$1
TARGET=$2

ready_file="${TARGET}"/"tmirror.ready"
MIRRORCHECK=$HOME/loadrc/."`hostname`".mirror.check

if [ -f ${MIRRORCHECK} ] && [ ! -f ${ready_file} ]
then
    echo -e "${red}tmirror must be run before mirror ... ${NC}"
    exit 1
fi

if [[ "${TARGET}" != *":"* ]] && [[ ! -d "${TARGET}" ]]
then
    mkdir -p "${TARGET}"
fi

rsync -aHS --delete-during --force \
    "${SOURCE}/" "${TARGET}/" \
    && if [ -f ${ready_file} ]
    then
        rm ${ready_file}
    fi
