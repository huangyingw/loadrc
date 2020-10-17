#!/bin/zsh

virsh list
virsh list --state-running --name | while read ss
do
    if [ ! -z "$ss" ]
    then
        echo "$ss :\n"
        virsh domifaddr "$ss"
    fi
done
