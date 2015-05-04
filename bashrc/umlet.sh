#!/bin/bash
if [ -z "$1" ];
then
    target=.
else
    target="$1"
fi
find "$target" -type f -name \*.uxf -exec umlet -filename={} \;
