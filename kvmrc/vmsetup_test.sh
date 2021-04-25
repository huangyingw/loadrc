#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./vmsetup.sh /var/lib/libvirt/images/u2004.qcow2
