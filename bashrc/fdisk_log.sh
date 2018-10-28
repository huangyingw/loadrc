#!/bin/bash -
logFile=~/loadrc/fdisk.log

df -TH > "$logFile"
fdisk -l >> "$logFile"
cat /etc/fstab >> "$logFile"
cat /etc/crypttab >> "$logFile"
mdadm -D /dev/md0 >> "$logFile"
blkid >> "$logFile"
ifconfig >> "$logFile"
cat /etc/network/interfaces >> "$logFile"
