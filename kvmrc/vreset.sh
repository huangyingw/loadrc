#!/bin/zsh
if [ -z "$1" ]
then
    virsh list|awk '/running/{print $2}'|while read ss; do virsh destroy "$ss" ; virsh start "$ss"; done
else
    TARGET=$1
    virsh destroy "$TARGET" ; virsh start "$TARGET"
fi
