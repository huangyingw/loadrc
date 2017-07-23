#!/bin/bash -
cd $(~/loadrc/gitrc/get_index.sh $pwd)
> COMMIT_EDITMSG
cd -
~/loadrc/gitrc/gclb.sh
~/loadrc/gitrc/gsync.sh
~/loadrc/gitrc/gps.sh
