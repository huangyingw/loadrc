#!/bin/bash - 
syncBranch=master
if [ -n "$1" ]
then 
  syncBranch="$1"
fi
if [ ! -f branch.default ]
then
  echo $syncBranch > branch.default
fi \
  && touch cscope.out \
  && touch default.only \
  && touch gme.default
