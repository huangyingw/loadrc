#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

while true
do
    ~/loadrc/bashrc/copy.sh "$1" "$2"
done
