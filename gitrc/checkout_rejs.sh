#!/bin/zsh
for ss in $(git status | grep \.rej$) ; \
do \
    targetFile=$(echo "$ss" | sed 's/\.rej$//g')
    git show "$1":"$targetFile" > "$targetFile" && \
        rm "$ss"
done
