#!/bin/zsh
if [ -z "$1" ]
then
    echo -e "${red}Please provide vmdk file ... ${NC}"
    exit 1
fi

if [ -z "$2" ]
then
    echo -e "${red}Please provide qcow2 file ... ${NC}"
    exit 1
fi

qemu-img convert -p -f vmdk -O qcow2 "$1" "$2"
