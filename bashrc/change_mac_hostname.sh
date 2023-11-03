#!/bin/zsh
if [ $(uname) != "Darwin" ]
then
    exit 0
fi

if [ -z "$1" ]
then
    echo -e "${red}Please provide hostname ... ${NC}"
    exit 1
fi

HOSTNAME="$1"
sudo scutil --set HostName "$HOSTNAME"
sudo scutil --set LocalHostName "$HOSTNAME"
sudo scutil --set ComputerName "$HOSTNAME"
dscacheutil -flushcache
~/loadrc/zerotierrc/all.sh
