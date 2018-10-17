#!/bin/bash - 
logFile=~/loadrc/fdisk.log

df -TH > "$logFile"
fdisk -l >> "$logFile"
cat /etc/fstab >> "$logFile"
cat /etc/crypttab >> "$logFile"
blkid >> "$logFile"
