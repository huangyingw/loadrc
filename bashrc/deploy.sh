#!/bin/bash -
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

for ss in $(git config --get-all deploy.target)
do
    ./rsync.sh "$ss"
done
