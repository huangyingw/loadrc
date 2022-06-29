#!/bin/zsh
~/loadrc/gitrc/dogdio.sh
git submodule status | awk '{print $2}' | parallel --jobs 0 'cd {}; ~/loadrc/gitrc/dogdio.sh'
