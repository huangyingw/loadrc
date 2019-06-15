#!/bin/bash - 
FILE="$1"
PARAM="$2"

SCRIPT=$(realpath "$FILE")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

cat "$FILE" | sed "s/\"//g" > "$FILE".sort

if [ "$PARAM" == "time" ]
then
    xargs ls -tr < "$FILE".sort | tee "$FILE"
elif [ "$PARAM" == "size" ]
then
    xargs ls -Sr < "$FILE".sort | tee "$FILE"
fi
