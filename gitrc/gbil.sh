#!/bin/bash - 
if [ ! -f gbil.findresult ];
then
  echo git bisect start > gbil.findresult
  exit 0
fi
