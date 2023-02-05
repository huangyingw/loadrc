#!/bin/zsh

if [[ "$(git config remote.origin.url)" != *'website.git' ]]
then
    echo -e "${red}ghypo only run for imvu website repo... ${NC}"
    exit 1
fi

if [ $(hostname) != "linb-sandbox" ]
then
    if [[ -n "$host" ]] && [[ "$host" != "localhost" ]]
    then
        ssh -nY "$host" "cd $rpath ; ~/loadrc/imvurc/ghypo.sh $1"
    fi
else
    ~/loadrc/gitrc/grsh.sh
    ~/loadrc/gitrc/gclean.sh
    git checkout -f master
    git branch -D "$1"
    git remote update
    git checkout -b "$1" origin/"$1"
    git checkout -f "$1"
    git branch -u origin/"$1"
    git merge -X theirs origin/"$1"

    if [ $(~/loadrc/gitrc/git_ready.sh) ]
    then
        s/hypo_best
        # s/hypo
        # s/hypo --buildbot=hypo2
    fi
fi
