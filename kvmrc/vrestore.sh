#!/bin/zsh
if [ -z "$1" ]
then
    find ~/kvm/ -type f -maxdepth 2 -name \*.save|while read ss; do virsh restore "$ss" && rm -v "$ss"; done
else
    virsh restore ~/kvm/"$1"/"$1".save \
        && rm -v ~/kvm/"$1"/"$1".save
fi
