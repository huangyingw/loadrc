#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}please provide the host name... ${NC}"
    exit 1
fi

remoteServer=$(echo "$1" | sed  -e "s/\/$//g")
mkdir -p ~/"$remoteServer"
mkdir -p ~/nfs/"$remoteServer" 

if [ $(uname) = "Linux" ]
then
    sshfs "$remoteServer":/media/ ~/"$remoteServer"
    df -TH
else
    diskutil unmount force ~/"$remoteServer" 
    ps ax | awk '/sshfs '$remoteServer'/NR > 1 {print $1}' | xargs kill -9
    sshfs "$remoteServer":/ ~/"$remoteServer"
    sudo mount -o nolocks -o resvport "$remoteServer":/media/ ~/nfs/"$remoteServer"
    df -H
fi
