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

branch=$(echo $1 | sed  -e "s/\//\\\\\//g")
sed -i.bak "s/\b[AMT]\b/git checkout $branch -- /g" gdif.findresult
sed -i.bak "s/\bD\b/git rm/g" gdif.findresult
sed -i.bak "s/^R[0-9]*/git mv/g" gdif.findresult
for ss in $(git config --get-all gdif.ignore)
do
    ss=$(echo $ss | sed  -e "s/\//\\\\\//g")
    sed -i.bak "/$ss/d" gdif.findresult
done

sort -u gdif.findresult -o gdif.findresult
