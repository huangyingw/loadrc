#!/bin/zsh

len="$1"
cat /dev/random | LC_ALL=C tr -dc A-Za-z0-9 | head -c "$len"
