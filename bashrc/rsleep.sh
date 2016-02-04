#!/bin/bash 
if [ -z "$1" ];
then
  /usr/bin/ssh mini "sudo pm-suspend" \
    & ping mini
  exit 1
fi
ssh "$1" pm-suspend
