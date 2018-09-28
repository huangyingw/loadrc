#!/bin/bash -
IFS=$'\r\n' GLOBIGNORE='*' command eval  'LINES=($(cat $1))'
/Applications/VLC.app/Contents/MacOS/VLC "${LINES[@]}"
