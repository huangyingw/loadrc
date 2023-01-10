#!/bin/zsh

IFS=$'\n'
for ss in $(git status | grep \.rej$) ; \
do \                                     
    targetFile=$(echo "$ss" | sed 's/\.rej$//g;s/^[[:space:]]//g')
    if [ "$2" = "f" ] || [ -n $(git config checkoutrejs.force) ] ; \
    then
        git checkout "$1" "$targetFile" && \
            rm "$ss"

    else
        git show "$1":"$targetFile" > "$ss"
    fi
done
