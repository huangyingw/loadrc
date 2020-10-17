#!/bin/zsh
#mdadm: at least 4 raid-devices needed for level 6
mdadm --create --verbose /dev/md0 --level=6 --raid-devices=4 /dev/sd[b-e]1
cryptsetup luksAddKey /dev/md0 /root/loadrc/keys/keyfile
mdadm --detail --scan >> /etc/mdadm/mdadm.conf
update-initramfs -u
reboot
