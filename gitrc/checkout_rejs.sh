#!/bin/zsh
for ss in $(git status | grep \.rej$) ; \
do \
    targetFile=$(echo "$ss" | sed 's/\.rej$//g')
    git checkout "$1" "$targetFile" && \
        rm "$ss"
done
