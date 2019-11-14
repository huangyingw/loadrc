#!/bin/bash -

if [ $(hostname) != "lint-sandbox" ]
then
    ssh -nY "$host" "cd $path ; ~/loadrc/imvurc/ghypo.sh $1"
else
    ~/loadrc/gitrc/grsh.sh
    ~/loadrc/gitrc/gclean.sh
    git remote update
    git checkout -b "$1" origin/"$1"
    git checkout "$1"
    git pull

    if [ $(~/loadrc/gitrc/git_ready.sh) ]
    then
        s/hypo
    fi
fi
