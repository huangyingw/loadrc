#!/bin/zsh

rpath="$1"

while [[ "$rpath" != "" && ! -e "$rpath/$2" ]]
do
    rpath=${rpath%/*}
done

echo "$rpath"
