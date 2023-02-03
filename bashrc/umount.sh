#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}please provide the host name... ${NC}"
    exit 1
fi

remoteServer=$(echo "$1" | sed  -e "s/\/$//g")

if [ $(uname) = "Linux" ]
then
    umount -l ~/"$remoteServer"
    # ~/loadrc/bashrc/rsleep.sh "$remoteServer" &
    df -TH
else
    diskutil unmountDisk force ~/"$remoteServer"
    # ~/loadrc/bashrc/rsleep.sh "$remoteServer" &
    df -H
fi
