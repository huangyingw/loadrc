#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./parse-github.sh git@github.com:gluster/glusterfs.git
./parse-github.sh https://github.com/gluster/glusterfs.git
