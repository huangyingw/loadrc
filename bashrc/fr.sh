#!/bin/zsh
FIND=$(echo $1 | sed 's/\//\\\//g')
REPLACE=$(echo $2 | sed 's/\//\\\//g')
xargs sed -i.bak  "s/${FIND}/${REPLACE}/g" < "$3"
