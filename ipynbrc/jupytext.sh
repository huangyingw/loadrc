#!/bin/zsh
TARGET="$PWD"

if [ -n "$1" ]
then
    TARGET="$1"
fi

find "$TARGET" -type f -name \*.ipynb | while read ss
do
    pyfile=$(echo "$ss" | sed 's/\.ipynb$/\.py/g')
    rm "$pyfile"
    jupytext --sync "$ss"
    autopep8 --in-place "$pyfile"
    sed -i.bak '/!pip install/d' "$pyfile"
done
