#!/bin/zsh
~/loadrc/gitrc/dogsync.sh &
git submodule status | awk '{print $2}' | parallel -j50 'cd {}; ~/loadrc/gitrc/dogsync.sh'
