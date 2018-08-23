#!/bin/bash -

for ss in $(git config --get-all deploy.target)
do
    ~/loadrc/bashrc/rsync.sh "$ss"
done
