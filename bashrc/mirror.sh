#!/bin/zsh

# Script Name: mirror.sh

# Check if both source and target parameters are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "${red}Please provide both source and target parameters... ${NC}"
    exit 1
fi

source="$1"
target="$2"

ready_file="$source"/"tmirror.ready"
MIRRORCHECK=$HOME/loadrc/."`hostname`".mirror.check

if [[ "${ready_file}" != *":"* ]] && [[ ! -f ${ready_file} ]]
then
    echo -e "${red}tmirror must be run before mirror ... ${NC}"
    exit 1
fi

# Call the rsync_folder_operations.zsh script with source, target, and the mode set to 'mirror'
~/loadrc/pythonrc/rsync_folder_operations.py "$source" "$target" "mirror" && \
    rm "$ready_file" && \
    if [ -f "${MIRRORCHECK}" ]; then
        ~/loadrc/bashrc/sleep.sh
    fi
