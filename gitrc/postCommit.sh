#!/bin/bash -
cd $(~/loadrc/gitrc/get_git.sh $pwd)
> COMMIT_EDITMSG
cd -

if [ "$commit_message" == "n" ]
then
    ~/loadrc/gitrc/gsync.sh
    ~/loadrc/gitrc/gps.sh
fi
