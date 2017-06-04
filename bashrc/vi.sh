#!/bin/bash
TARGET=cscope.findresult
if [ -z "$1" ];
then
  if [ -f "$TARGET" ]
  then
    vim $TARGET
  fi
else
  vim "$1"
fi
