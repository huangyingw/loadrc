#!/bin/bash
git add . \
  && git stash \
  && git stash apply stash@{0} \
  && git reset HEAD .
