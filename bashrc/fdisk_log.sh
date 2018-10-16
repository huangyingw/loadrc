#!/bin/bash - 
logFile=~/loadrc/fdisk.log

df -TH > "$logFile"
cat /etc/fstab >> "$logFile"
blkid >> "$logFile"
