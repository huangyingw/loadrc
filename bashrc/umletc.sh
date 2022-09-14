#!/bin/zsh

if [ -z "$1" ]
then
    target=.
else
    target="$1"
fi

find "$target" -type f -name \*.uxf|while read ss
do
    output="`echo "$ss"|sed  -e "s/\.uxf$/\.pdf/g"`"
    umlet -action=convert -format=pdf -filename="$ss" -output="$output"
done
