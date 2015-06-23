#!/bin/bash
TARGET=`echo "$1" |sed 's/\.qcow2//g'`
DIRECTORY=`echo "$1" |sed 's/\/\w\+.qcow2//g'`
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p "$DIRECTORY"
fi 
qemu-img create -f qcow2 "$TARGET".qcow2  1000G
