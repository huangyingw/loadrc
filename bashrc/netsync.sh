#!/bin/bash 
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if [ -z "$1" ];
then
  echo -e "${red}please specify the source server ... ${NC}"
  exit 0
fi
SOURCE="$1"
NETSYNC="$HOME/loadrc/bashrc/netsync_ex"
exclude_params=();
while read suf
do
  exclude_params+=( "--exclude=$suf" )
done < "$NETSYNC"
rsync -e ssh -aH --delete-during --force "${exclude_params[@]}" "${SOURCE}":/ / \
  && scp "${SOURCE}":/boot/vmlinuz-* "${SOURCE}":/boot/initrd.img-*   /boot/ \
  && update-initramfs -u \
  && update-grub2 \
  && reboot
