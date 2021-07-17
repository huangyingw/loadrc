#!/bin/zsh

for ss in $(git status | grep \.rej$) ; \
do \
    targetFile=$(echo "$ss" | sed 's/\.rej$//g')
    if [ "$2" = "f" ]
    then
        git checkout "$1" "$targetFile" && \
            rm "$ss"
    else
        git show "$1":"$targetFile" > "$ss"
    fi
done

git show "$1":COMMIT_EDITMSG > COMMIT_EDITMSG
