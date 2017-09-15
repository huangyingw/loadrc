#!/bin/bash -
if [ ! -f "$1" ] || [ -z "$1" ];
then
    echo -e "${red}Please provide the full path to qcow2 file... ${NC}"
    exit 1
fi
qcow2File="$1"
~/loadrc/kvmrc/vmount.sh "$qcow2File"
