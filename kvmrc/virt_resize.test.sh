#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./virt_resize.sh /media/nvme/var/lib/libvirt/images/gluster00.qcow2 30G
