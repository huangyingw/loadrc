#!/bin/zsh
if [ -z "$1" ]
then
    echo -e "${red}please provide the host name... ${NC}"
    exit 1
fi

remoteServer=$(echo "$1" | sed  -e "s/\/$//g")
mkdir -p ~/"$remoteServer"

if [ $(uname) = "Linux" ]
then
    sshfs "$remoteServer":/media/ ~/"$remoteServer"
    df -TH
else
    sudo mount -o nolocks -o resvport "$remoteServer":/media/ ~/"$remoteServer" || \
        sshfs "$remoteServer":/ ~/"$remoteServer"

    df -H
fi
