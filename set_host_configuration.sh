#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

TARGET="$1"
SOURCE=~/loadrc/"`hostname`$TARGET"
if [ -f "$SOURCE" ]
then
    cp -fv "$SOURCE" "$TARGET"
fi
