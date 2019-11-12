#!/bin/zsh
~/loadrc/gitrc/checkGitStatus.sh

if [ $? -ne 0 ]
then
    exit 1
fi

FIND=$(echo $1 | sed 's/\//\\\//g')
REPLACE=$(echo $2 | sed 's/\//\\\//g')
xargs sed -i""  "s/\b${FIND}\b/${REPLACE}/g" < files.proj
