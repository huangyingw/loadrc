#!/bin/zsh
for file in `ls .`
do
    cd $file
    git init
    git add .
    ~/loadrc/gitrc/g.sh
    $HOME/loadrc/gitrc/gclb.sh
    cd - 1>/dev/null
done
