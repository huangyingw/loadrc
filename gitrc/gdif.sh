#!/bin/bash
~/loadrc/gitrc/include_gitconfig.sh

if [ -n "$1" ]
then
    COMMAND="git diff --name-status $1"

    for ss in $(git config --get-all gdif.ignore)
    do
        COMMAND="$COMMAND  ':(exclude)$ss'"
    done

    eval "$COMMAND" | tee gdif.findresult
else
    if [ -z "$(git status --porcelain)" ]
    then
        git diff --name-status `git log --oneline|awk 'NR==2{print $1}'` | tee gdif.findresult
    else
        git diff --name-status HEAD | tee gdif.findresult
    fi
fi

branch=$(echo $1 | sed  -e "s/\//\\\\\//g")
sed -i.bak "s/\b[AMT]\b/git checkout $branch -- /g" gdif.findresult
sed -i.bak "s/\bD\b/git rm/g" gdif.findresult
sed -i.bak "s/^R[0-9]*/git mv/g" gdif.findresult
sort -u gdif.findresult -o gdif.findresult
