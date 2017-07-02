#!/bin/bash

if [ -z "$1" ];
then
    echo -e "${red}Please provide parameter ... ${NC}"
    exit 1
fi

if [ -n "$2" ];
then
    git diff --name-status "$1" "$2" | tee gdif.findresult
else
    git diff --name-status HEAD "$1" | tee gdif.findresult
fi

OS=`uname`
if [ "$OS" == "Linux" ]
then
    sed -i.bak "s/\b[AMT]\b/git checkout $1 -- /g" gdif.findresult
    sed -i.bak "s/\bD\b/git rm/g" gdif.findresult
    sed -i.bak "s/^R[0-9]*/git mv/g" gdif.findresult
    for ss in $(git config --get-all gdif.ignore)
    do
        sed -i.bak "/$ss/d" gdif.findresult
    done
else
    sed -i.bak "s/[[:<:]]D[[:>:]]/git rm/g" gdif.findresult
    sed -i.bak "s/[[:<:]][AMT][[:>:]]/git checkout $1 -- /g" gdif.findresult
    sed -i.bak "s/^R[0-9]*/git mv/g" gdif.findresult
    for ss in $(git config --get-all gdif.ignore)
    do
        sed -i.bak "/$ss/d" gdif.findresult
    done
fi
sort -u gdif.findresult -o gdif.findresult
