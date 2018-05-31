#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

IFS=$'\r\n' GLOBIGNORE='*' command eval  'LINES=($(cat $1))'

for index in "${!LINES[@]}"
do
    for ((next = $index + 1; next < ${#LINES[@]}; next++));
    do
        kdiff3 "${LINES[$index]}" "${LINES[$next]}"
    done
done
