#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

. ~/loadrc/dockerrc/getContainerID.sh "$1"
docker logs "$CONTAINERID"
