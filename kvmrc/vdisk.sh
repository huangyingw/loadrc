#!/bin/bash
TARGET=$(basename "$1")
DIRECTORY=$(dirname "$1")

if [ ! -d "$DIRECTORY" ];
then
    mkdir -p "$DIRECTORY"
fi

minimumsize=500
fSize=$(du -k "$1" | cut -f 1)

if [ ! -f "$1" ] || [ $fSize -lt $minimumsize ];
then
    qemu-img create -f qcow2 "$1" 300G
fi
