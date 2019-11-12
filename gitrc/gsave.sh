#!/bin/bash
git stash \
    && git stash apply stash@{0}
