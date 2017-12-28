#!/bin/bash
if [ -z "$1" ]
then
    find /media/volgrp/kvm/ -type f -maxdepth 2 -name \*.save|while read ss; do virsh restore "$ss" && rm -v "$ss"; done
else
    virsh restore /media/volgrp/kvm/"$1"/"$1".save \
        && rm -v /media/volgrp/kvm/"$1"/"$1".save
fi
