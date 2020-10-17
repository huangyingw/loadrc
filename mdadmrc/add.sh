#!/bin/zsh
mdadm --manage /dev/md0 --run
mdadm --manage /dev/md0 --add /dev/sdf1
mdadm -v --grow --raid-devices=5 /dev/md0
mdadm --grow /dev/md0 --size=max

reboot
e2fsck -f /dev/mapper/md0_crypt
resize2fs /dev/mapper/md0_crypt
