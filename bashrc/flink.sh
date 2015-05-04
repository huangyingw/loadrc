#!/bin/bash
TARGET=.
if [ -n "$1" ]
then 
    TARGET="$1"
fi
find "${TARGET}" -type l -exec ls -ld {} \;
