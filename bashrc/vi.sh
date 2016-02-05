#!/bin/bash
TARGET='/export/home1/username/cscope_db/'`pwd |sed -e "s/^.*\///g"`
if [ -z "$1" ];
then
  if [ -f "$TARGET" ]
  then
    vim $TARGET
  else
    vim ~/cscope.findresult
  fi
else
  vim "$1"
fi
