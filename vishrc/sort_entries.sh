#!/bin/zsh
FILE="$1"
PARAM="$2"

SCRIPT=$(realpath "$FILE")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

IFS=$'\n'

if [ "$PARAM" = "time" ]
then
    ls -t $(cat "$FILE" | sed 's/^"//g;s/"$//g;s/\\ / /g') | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > "$FILE"
elif [ "$PARAM" = "size" ]
then
    ls -S $(cat "$FILE" | sed 's/^"//g;s/"$//g;s/\\ / /g') | sed 's/\(["'\''\]\)/\\\1/g;s/.*/"&"/' > "$FILE" 
fi
