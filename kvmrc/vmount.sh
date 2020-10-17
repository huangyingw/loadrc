#!/bin/zsh
if [ ! -f "$1" ] || [ -z "$1" ]
then
    echo -e "${red}Please provide the full path to qcow2 file... ${NC}"
    exit 1
fi
modprobe nbd max_part=8
~/loadrc/kvmrc/uvmount.sh
qcow2File="$1"
qemu-nbd --connect=/dev/nbd0 "$qcow2File"

for ss in $(fdisk /dev/nbd0 -l | awk '/nbd0p/{print $1}')
do
    echo $ss
    mkdir -p /media/$ss
    mount $ss /media/$ss
done
