#!/bin/zsh 

input=/dev/nbd0
output=/media/volgrp/software/os/ubuntu/u2004.img
# dd if="$input" bs=4096 conv=sync,noerror | (pv -s $(fdisk -l "$input" | grep -o '[0-9]*\{1\} GiB' | awk '{print $1}')g) | dd of="$output" 
(pv -n "$input" | dd of="$output" bs=128M conv=notrunc,noerror) 2>&1 | dialog --gauge "Running dd command (cloning), please wait..." 10 70 0
