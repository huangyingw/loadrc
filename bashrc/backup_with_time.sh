#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt"
