#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

mkdir -p /media/nvme/var/lib/docker/
service docker stop
~/loadrc/bashrc/mklnk.sh /var/lib/docker/ /media/nvme/var/lib/docker/
