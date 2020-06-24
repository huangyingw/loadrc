#!/bin/zsh

if [ $(hostname) != "linb-sandbox" ]
then
    ssh -nY "$host" "cd $rpath ; ~/loadrc/imvurc/ghypo.sh $1"
else
    ~/loadrc/gitrc/grsh.sh
    ~/loadrc/gitrc/gclean.sh
    git remote update
    git checkout -b "$1" origin/"$1"
    git pull --rebase

    if [ $(~/loadrc/gitrc/git_ready.sh) ]
    then
        s/hypo
    fi
fi
