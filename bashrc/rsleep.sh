#!/bin/bash 
if [ -z "$1" ];
then
  /usr/bin/ssh timemachine "sudo pm-suspend" \
    & ping timemachine
  exit 1
fi
ssh "$1" pm-suspend
