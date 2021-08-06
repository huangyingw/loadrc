#!/bin/zsh

FIND=$(echo $1 | sed 's/\//\\\//g')
REPLACE=$(echo $2 | sed 's/\//\\\//g')

if [[ "$4" == "w" ]]
then
    if [ $(uname) = "Darwin" ]
    then
        xargs sed -i.bak "s/[[:<:]]${FIND}[[:>:]]/${REPLACE}/g" < "$3"
    else
        xargs sed -i.bak "s/\b${FIND}\b/${REPLACE}/g" < "$3"
    fi
else
    xargs sed -i.bak  "s/${FIND}/${REPLACE}/g" < "$3"
fi
