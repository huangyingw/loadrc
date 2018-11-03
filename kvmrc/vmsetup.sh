#!/bin/bash -
if [ ! -f "$1" ] || [ -z "$1" ]
then
    echo -e "${red}Please provide the full path to qcow2 file... ${NC}"
    exit 1
fi
qcow2File="$1"
~/loadrc/kvmrc/uvmount.sh
~/loadrc/kvmrc/vmount.sh "$qcow2File"
rsync -aHSv --progress --delete-before --force ~/loadrc/ /media/dev/nbd0p1/root/loadrc/
rsync -aHSv --progress --delete-before --force ~/.ssh/ /media/dev/nbd0p1/root/.ssh/
~/loadrc/kvmrc/uvmount.sh
