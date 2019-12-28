#!/bin/zsh
find "$1" -type f -name \*.html | while read ss
do
    targetFile=$(echo $ss | sed 's/\.html$/\.pdf/g')

    if [ ! -f "$targetFile" ]
    then
        wkhtmltopdf "$ss" "$targetFile" && rm "$ss"
    else
        rm "$ss"
    fi
done
