#!/bin/zsh
for ss in $(git status | grep \.rej$) ; \
do \
    git checkout "$1" $(echo "$ss" | sed 's/\.rej$//g') && \
    rm "$ss" ; \
done
