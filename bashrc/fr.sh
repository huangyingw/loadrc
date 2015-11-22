#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if ! (git status|grep -q 'nothing to commit')
then
  echo -e "${red}the git repository is unclean, please check it before continuing... ${NC}"
  exit 1
fi
FIND=$(echo $1 | sed 's/\//\\\//g')
REPLACE=$(echo $2 | sed 's/\//\\\//g')
cscope_db_file="/export/home1/username/cscope_db/""${PWD##*/}"
OS=`uname`
if [ "$OS" == "Linux" ]
then
  xargs sed -i""  "s/\b${FIND}\b/${REPLACE}/g" < "$cscope_db_file"
else
  xargs sed -i ""  "s/[[:<:]]${FIND}[[:>:]]/${REPLACE}/g" < "$cscope_db_file"
fi
