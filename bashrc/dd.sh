#!/bin/zsh 

input=/dev/nbd0
output=/media/volgrp/image.img
dd if="$input" bs=4096 conv=sync,noerror | (pv -s $(fdisk -l "$input" | grep -o '[0-9]*\{1\} GiB' | awk '{print $1}')g) | dd of="$output" 
dd if=/media/volgrp/image.img of=/dev/nbd0 bs=16M
