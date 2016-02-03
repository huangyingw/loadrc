#!/bin/bash
# this is used to reset back to the latest change on the file.
commit=`git rev-list --branches -n 1 HEAD -- "$1"`
if [ -z "$1" ];
then
  git st|awk '/modified:/{print $2}'|while read ss \
    ; do cp -fv "$ss" "$ss".bak \
    && git checkout -- "$ss" \
    ; done
else
  cp -fv "$1" "$1".bak \
    && git checkout -- "$1"
fi
