#!/bin/bash -
if [ ! -f .gitconfig ]
then
    exit 0
fi

config=$(~/loadrc/gitrc/get_index.sh)
git config --local include.path $(realpath --relative-to="$config" .gitconfig)
