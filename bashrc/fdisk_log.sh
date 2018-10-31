#!/bin/bash -
logFile=~/loadrc/fdisk.log

df -TH > "$logFile"
fdisk -l >> "$logFile"
cat /etc/fstab >> "$logFile"
cat /etc/crypttab >> "$logFile"
DEVICE=`mdadm -D --scan|awk '{print $2}'`
mdadm -D "$DEVICE" >> "$logFile"
blkid >> "$logFile"
ifconfig >> "$logFile"
cat /etc/network/interfaces >> "$logFile"
