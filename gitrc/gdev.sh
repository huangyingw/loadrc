#!/bin/bash - 
if [ ! -f branch.default ]; then
  echo master > branch.default
fi \
  && touch cscope.out \
  && touch dropbox.only \
  && touch gme.default
