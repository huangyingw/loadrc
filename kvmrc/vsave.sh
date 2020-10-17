#!/bin/zsh
$HOME/loadrc/kvmrc/vresume.sh
if [ -z "$1" ]
then
    virsh list|awk '/running/{print $2}'|while read ss; do virsh save "$ss" ~/kvm/"$ss"/$ss.save --verbose; done
else
    virsh save "$1" ~/kvm/"$1"/"$1".save --verbose
fi
