#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./parse_github.sh git@github.com:gluster/glusterfs.git
./parse_github.sh https://github.com/gluster/glusterfs.git
