#!/bin/zsh
mdadm /dev/md0 -f /dev/sda1
mdadm --manage /dev/md0 --add /dev/sda1
mdadm --manage /dev/md0 --remove /dev/sda1
