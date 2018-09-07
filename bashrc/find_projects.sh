#!/bin/bash -
if [ -z "$1" ]
then
    find . -type f -name files.proj -exec realpath {} \; | sed 's/\(["'\''\]\)/\\\1/g;s/ /\\ /g;s/.*/"&"/'
else
    find "$1" -type f -name files.proj -exec realpath {} \; | sed 's/\(["'\''\]\)/\\\1/g;s/ /\\ /g;s/.*/"&"/'
fi

sort -u ~/all.proj -o ~/all.proj
