#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

mkdir -p /media/nvme/var/lib/libvirt/
mkdir -p /media/nvme/etc/libvirt/
~/loadrc/bashrc/mklnk.sh /var/lib/libvirt/ /media/nvme/var/lib/libvirt/
~/loadrc/bashrc/mklnk.sh /etc/libvirt/ /media/nvme/etc/libvirt/
