#!/bin/bash -
if [ ! -f .gitconfig ]
then
    exit 0
fi

git config --local include.path $(realpath .gitconfig)
