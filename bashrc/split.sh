#!/bin/zsh
gsplit -l 1 --numeric-suffixes --additional-suffix=.json "$1" "$1"
