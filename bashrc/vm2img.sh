#!/bin/zsh

input=/var/lib/libvirt/images/u2004.qcow2 
output=$(echo "$input" | sed 's/\.qcow2$/\.img/g;s/\.hds$/\.img/g')
echo "output --> $output"

#qemu-img convert "$input" -O raw "$output"

(qemu-img convert "$input" -O raw "$output") 2>&1 | dialog --gauge "Running dd command (cloning), please wait..." 10 70 0
