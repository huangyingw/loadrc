#!/bin/bash -

if [ $(hostname) != "lint-sandbox" ]
then
    ssh -nY "$host" "cd $path ; ~/loadrc/imvurc/ghypo.sh $1"
else
    ~/loadrc/gitrc/grsh.sh
    ~/loadrc/gitrc/gclean.sh
    git remote update
    git checkout -b "$1" origin/"$1"
    s/hypo
fi
