#!/bin/zsh
for ss in $(fdisk /dev/nbd0 -l | awk '/nbd0p/{print $1}')
do
    umount $ss
done
qemu-nbd --disconnect /dev/nbd0
df -TH
