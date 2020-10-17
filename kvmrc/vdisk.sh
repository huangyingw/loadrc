#!/bin/zsh
TARGET=$(basename "$1")
DIRECTORY=$(dirname "$1")

if [ ! -d "$DIRECTORY" ]
then
    mkdir -p "$DIRECTORY"
fi

size=500G

if [ -n "$2" ]
then
    size="$2"
fi

minimumsize=500
fSize=$(du -k "$1" | cut -f 1)

if [ ! -f "$1" ] || [ $fSize -lt $minimumsize ]
then
    qemu-img create -f qcow2 "$1" "$size"
fi
