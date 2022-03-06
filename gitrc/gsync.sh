#!/bin/zsh
~/loadrc/gitrc/dogsync.sh &
git submodule status | awk '{print $2}' | xargs -P100 -n1 ~/loadrc/gitrc/dogsync.sh
