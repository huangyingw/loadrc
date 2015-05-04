#!/bin/bash
if [ -n "$1" ];
then
  git stash drop stash@{"$1"}
fi
