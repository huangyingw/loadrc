#!/bin/bash -
SCRIPT=$(realpath "$1")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"
IFS=$'\r\n' GLOBIGNORE='*' command eval  'LINES=($(cat $1))'
/Applications/VLC.app/Contents/MacOS/VLC "${LINES[@]}"
