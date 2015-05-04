#!/bin/bash
# this is used to reset back to the latest change on the file.
commit=`git rev-list --branches -n 1 HEAD -- "$1"`
cp -fv "$1" "$1".bak \
  && git checkout $commit -- "$1"
