#!/bin/zsh
if [ -z "$1" ]
then
    echo -e "${red}please specify the source server ... ${NC}"
    exit 1
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
