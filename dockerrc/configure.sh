#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

mkdir -p /media/nvme/var/lib/docker/
/etc/init.d/docker stop
~/loadrc/bashrc/mklnk.sh /var/lib/docker/ /media/nvme/var/lib/docker/
