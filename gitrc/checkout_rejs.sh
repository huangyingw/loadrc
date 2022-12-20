#!/bin/zsh

for ss in $(git status | grep \.rej$) ; \
do \                                     
    targetFile=$(echo "$ss" | sed 's/\.rej$//g')
    targetFile=$(echo "$targetFile" | sed 's/\(["'\''\]\)/\\\1/g;s/ /\\ /g')
    if [ "$2" = "f" ] || [ $(git config checkoutrejs.force) ]
    then
        git checkout "$1" "$targetFile" && \
            rm "$ss"
    else
        git show "$1":"$targetFile" > "$ss"
    fi
done
