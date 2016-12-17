#!/bin/bash
if [ -z "$1" ];
then
    echo -e "${red}please provide the host name... ${NC}"
    exit 1
fi
ps ax|awk '/sshfs/{print $1}'|while read ss; do kill -9 "$ss"; done
OS=`uname`
if [ "$OS" == "Linux" ]
then
    umount /media/samba
    sshfs "$1":/media /media/samba
else
    diskutil unmountDisk force ~/samba
    sshfs "$1":/ ~/samba
fi

df \
    && cd ~/samba \
    && echo -e "${green}$(pwd) ${NC}" "in"  "${green}$1 ${NC}"
