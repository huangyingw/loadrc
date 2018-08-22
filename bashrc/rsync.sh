#!/bin/bash -
. ~/loadrc/bashrc/find_up_goto.sh files.proj
cat files.proj | sed 's/^"//g;s/"$//g' > files.proj.tmp
rsync -aHv --force --progress \
    --files-from=files.proj.tmp \
    . \
    "$1"
