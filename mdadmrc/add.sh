#!/bin/bash -
mdadm --create --verbose /dev/md0 --level=5 --raid-devices=3 /dev/sdb1 /dev/sdc1 /dev/sdd1 --spare-devices=1 /dev/sde1
mdadm --manage /dev/md0 --run
mdadm --manage /dev/md0 --add /dev/sd[b-d]
mdadm --grow /dev/md0 --size=max
reboot
