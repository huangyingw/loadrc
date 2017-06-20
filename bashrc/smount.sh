#!/bin/bash
if [ -z "$1" ];
then
    echo -e "${red}please provide the host name... ${NC}"
    exit 1
fi

OS=`uname`
if [ "$OS" == "Linux" ]
then
    sudo umount -l ~/"$1"
    mkdir -p ~/"$1"
    sshfs "$1":/ ~/"$1"
    df -TH
else
    diskutil unmountDisk force ~/samba
    mkdir -p ~/"$1"
    sshfs "$1":/ ~/"$1"
    df -H
fi
