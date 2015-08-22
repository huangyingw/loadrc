#!/bin/bash 
if [ -z "$1" ];
then
  /usr/bin/ssh vserver "sudo pm-suspend" \
    & ping vserver
  exit 1
fi
ssh "$1" pm-suspend
