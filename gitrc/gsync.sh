#!/bin/zsh
~/loadrc/gitrc/dogsync.sh &
git submodule foreach ~/loadrc/gitrc/dogsync.sh &
