#!/bin/bash
if [ -z "$1" ];
then
  find /media/volgrp/kvm/save/ -type f -maxdepth 1 -name \*.save|while read ss; do virsh restore $ss && rm -v $ss; done
else
  virsh restore /media/volgrp/kvm/save/"$1".save \
    && rm -v /media/volgrp/kvm/save/"$1".save
fi
