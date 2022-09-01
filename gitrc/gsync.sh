#!/bin/zsh
~/loadrc/gitrc/dogsync.sh
git submodule status | awk '{print $2}' | parallel --jobs 0 'cd {}; ~/loadrc/gitrc/dogsync.sh; cd -'
