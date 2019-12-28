#!/bin/zsh
SCRIPT=$(realpath "$1")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

find . -type f -name \*.html | while read ss
do
    targetFile=$(echo $ss | sed 's/\.html$/\.pdf/g')

    if [ ! -f "$targetFile" ]
    then
        wkhtmltopdf "$ss" "$targetFile" && rm "$ss"
    else
        rm "$ss"
    fi
done
