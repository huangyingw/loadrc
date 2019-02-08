#!/bin/bash -
DIR=$(dirname "$1")
cd "$DIR"

cd $(git rev-parse --show-toplevel)
if [ -f .git ]
then
    relative=$(cat .git | awk '{print $2}')
    echo $(realpath "$relative")
else
    echo $(realpath .git)
fi
