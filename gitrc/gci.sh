#!/bin/bash
. ~/loadrc/gitrc/getCommit_message.sh "$1"
git commit -am "$commit_message"
> .git/COMMIT_EDITMSG
~/loadrc/gitrc/gclb.sh
~/loadrc/gitrc/gsync.sh              
~/loadrc/gitrc/gps.sh              
