#!/bin/bash -
#mdadm: at least 4 raid-devices needed for level 6
mdadm --create --verbose /dev/md0 --level=6 --raid-devices=4 /dev/sd[b-d] --spare-devices=1 /dev/sde1
cryptsetup luksAddKey /dev/md0 /root/loadrc/keys/keyfile
mdadm --manage /dev/md0 --run
mdadm --manage /dev/md0 --add /dev/sd[c-d]
mdadm --grow /dev/md0 --size=max
reboot
e2fsck -f /dev/mapper/md0_crypt
resize2fs /dev/mapper/md0_crypt
