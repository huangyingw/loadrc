#!/bin/bash -

path="$1"

while [[ !"$path" = "" && ! -e "$path/$2" ]]
do
    path=${path%/*}
done

if [ -f "$path/$2" ]
then
    echo "$path/$2"
fi
