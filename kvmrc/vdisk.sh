#!/bin/bash
TARGET=$(basename "$1")
DIRECTORY=$(dirname "$1")
if [ ! -d "$DIRECTORY" ];
then
  mkdir -p "$DIRECTORY"
fi 
qemu-img create -f qcow2 "$1" 500G
