#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./vm2img.sh /var/lib/libvirt/images/u2004.qcow2
