#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

. ~/loadrc/dockerrc/getContainerID.sh "$1"
docker exec \
  -it "$CONTAINERID" bash
