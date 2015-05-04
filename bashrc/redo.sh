#!/bin/bash
if [ -z "$1" ];
then
  echo "Please provide commit message"
  exit 1
fi
pattern=$1
shift
history | awk '/'$pattern'/ { print $1 }'
