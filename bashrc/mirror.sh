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

iconvs=$(~/loadrc/bashrc/get_iconvs.sh "$source" "$target")
rsyncpath=$(~/loadrc/bashrc/get_rsyncpath.sh "$source" "$target")
rsync_basic_options=($(< ~/loadrc/bashrc/rsync_basic_options))

rsync \
    --delete-before \
    "${rsync_basic_options[@]}" \
    "$iconvs" \
    "$rsyncpath" \
    "$source/" "$target/" && \
    if [ -f "${MIRRORCHECK}" ] ; \
    then \
        ~/loadrc/bashrc/sleep.sh ; \
    fi
