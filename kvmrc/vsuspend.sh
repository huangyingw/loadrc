#!/bin/zsh
if [ -z "$1" ]
then
    virsh list|awk '/running/{print $2}'|while read ss; do virsh suspend $ss; done
else
    virsh suspend "$1"
fi
