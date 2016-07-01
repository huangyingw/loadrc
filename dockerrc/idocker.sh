#!/bin/bash - 
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

. ~/loadrc/dockerrc/getContainerID.sh "$1"
docker inspect "$CONTAINERID" > idocker.json
vi idocker.json
