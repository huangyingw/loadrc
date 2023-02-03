#!/bin/zsh

if [ ! -f "$1" ] || [ -z "$1" ]
then
    echo -e "${red}Please provide the full path to qcow2 file... ${NC}"
    exit 1
fi

qcow2File="$1"
~/loadrc/kvmrc/uvmount.sh
~/loadrc/kvmrc/vmount.sh "$qcow2File"
nbd0p=$(df -TH | awk '/\/dev\/nbd0.*ext4/{print $7}')

if [ -n "$nbd0p" ]
then
    mkdir -p "$nbd0p"/root/loadrc/
    rsync -aHSv --progress --delete-before --force ~/.ssh/ "$nbd0p"/root/.ssh/
    rsync -aHSv --progress ~/loadrc/.tmux.conf "$nbd0p"/root/
    rsync -aHSv --progress ~/loadrc/ "$nbd0p"/root/loadrc/
    rsync -aHSv --progress ~/loadrc/linux/etc/ssh/ "$nbd0p"/etc/ssh/
fi

~/loadrc/kvmrc/uvmount.sh
