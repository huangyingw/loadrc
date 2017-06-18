#!/bin/bash - 
if [ ! -f "$1" ] || [ -z "$1" ];
then
  echo -e "${red}Please provide the full path to qcow2 file... ${NC}"
  exit 1
fi
modprobe nbd max_part=8
umount -fl /media/nbd0
qemu-nbd --disconnect /dev/nbd0
qcow2File="$1"
qemu-nbd --connect=/dev/nbd0 "$qcow2File"
mount $(fdisk /dev/nbd0 -l|awk '/nbd0/ {a=$1} END{print a}') /media/nbd0 
df -TH
