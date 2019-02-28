#!/bin/bash -

if [ $(hostname) != "lint-sandbox" ]
then
    ssh -nY "$host" "cd $path ; ~/loadrc/imvurc/ghypo.sh $1"
    exit 0
fi


~/loadrc/gitrc/grsh.sh
~/loadrc/gitrc/gclean.sh
git co master
git remote update
git branch -D "$1"
git co -b "$1" origin/"$1"
s/hypo
