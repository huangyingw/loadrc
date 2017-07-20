#!/bin/bash

function upsearch () {
    test / == "$pwd" && return || test -e "$1" && echo "found: " "$pwd" && return || cd .. && upsearch "$1"
}

TARGET=files.proj

if [ -z "$1" ];
then
    if [ -f "$TARGET" ]
    then
        vim $TARGET
    fi
else
    vim "$1"
fi

upsearch "$TARGET"
