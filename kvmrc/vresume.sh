#!/bin/zsh
if [ -z "$1" ]
then
    virsh list|awk '/paused/{print $2}'|while read ss; do virsh resume $ss; done
else
    virsh resume  "$1"
fi
