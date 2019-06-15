#!/bin/bash -
FILE="$1"
PARAM="$2"

SCRIPT=$(realpath "$FILE")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

IFS=$'\n'

if [ "$PARAM" == "time" ]
then
    ls -tr $(cat "$FILE") > "$FILE"
elif [ "$PARAM" == "size" ]
then
    ls -S $(cat "$FILE") > "$FILE" 
fi
