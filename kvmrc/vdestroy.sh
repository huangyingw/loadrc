#!/bin/zsh
if [ -z "$1" ]
then
    virsh list|awk '/[running|paused]/{print $2}'|while read ss; do virsh destroy "$ss" ; done
else
    TARGET=$1
    virsh destroy "$TARGET"
fi
