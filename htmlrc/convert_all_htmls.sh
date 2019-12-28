#!/bin/zsh
SCRIPT=$(realpath "$1")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

find . -type f -name \*.html | while read ss
do
    wkhtmltopdf "$ss" $(echo $ss | sed 's/\.html$/\.pdf/g') && rm "$ss"
done
