#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./virt_resize.sh /media/nvme/var/lib/libvirt/images/u1804.qcow2 20G
