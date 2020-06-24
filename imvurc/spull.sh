#!/bin/zsh

if [ $(hostname) != "linb-sandbox" ]
then
    ssh -nY "$host" "cd $rpath ; ~/loadrc/imvurc/spull.sh $1"
else
    ~/loadrc/gitrc/grsh.sh
    ~/loadrc/gitrc/gclean.sh
    git remote update
    git checkout -b "$1" origin/"$1"
    git checkout "$1"
    s/pull && \
        git pull --rebase && \
        git push
fi
