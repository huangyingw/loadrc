#!/bin/bash -
if [ ! -f "$1" ] || [ -z "$1" ]
then
    echo -e "${red}Please provide the full path to qcow2 file... ${NC}"
    exit 1
fi
qcow2File="$1"
~/loadrc/kvmrc/uvmount.sh
~/loadrc/kvmrc/vmount.sh "$qcow2File"
~/loadrc/bashrc/mirror.sh /root/ /media/dev/nbd0p1/root/
~/loadrc/bashrc/mirror.sh /etc/ssh/ /media/dev/nbd0p1/etc/ssh/
cp -v /media/volgrp/software/nx/nomachine_*.deb  /media/dev/nbd0p1/root/ 
~/loadrc/kvmrc/uvmount.sh
