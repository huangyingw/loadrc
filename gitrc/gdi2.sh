#!/bin/bash -
if [ -z "$1" ]
then
    echo -e "${red}Please provide branch name ... ${NC}"
fi

branch="$1"
~/loadrc/gitrc/gdi.sh "$branch"  2>&1 | tee gdi.findresult && \
    git co "$branch" && \
    ~/loadrc/gitrc/gsync.sh && \
    git apply gdi.findresult && \
    ~/loadrc/gitrc/gwap.sh
