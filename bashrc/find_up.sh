#!/bin/zsh

rpath="$1"

while [[ !"$rpath" = "" && ! -e "$rpath/$2" ]]
do
    rpath=${rpath%/*}
done

if [ -f "$rpath/$2" ]
then
    echo "$rpath/$2"
fi
