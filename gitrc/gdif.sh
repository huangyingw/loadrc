#!/bin/bash
if [ -n "$1" ];
then
    if [ -n "$2" ];
    then
        git diff --name-status "$1" "$2" | tee gdif.findresult
    else
        git diff --name-status HEAD "$1" | tee gdif.findresult
    fi
else
    if [ -z "$(git status --porcelain)" ]
    then
        git diff --name-status `git log --oneline|awk 'NR==2{print $1}'` | tee gdif.findresult
    else
        git diff --name-status | tee gdif.findresult
    fi
fi

sed -i.bak "s/\b[AMT]\b/git checkout $1 -- /g" gdif.findresult
sed -i.bak "s/\bD\b/git rm/g" gdif.findresult
sed -i.bak "s/^R[0-9]*/git mv/g" gdif.findresult
for ss in $(git config --get-all gdif.ignore)
do
    sed -i.bak "/$ss/d" gdif.findresult
done

sort -u gdif.findresult -o gdif.findresult
