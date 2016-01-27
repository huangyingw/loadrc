#!/bin/bash

if [ -z "$1" ];
then
  echo -e "${red}Please provide parameter ... ${NC}"
  exit 1
else
  x=`echo $1 | sed -e "s|Dropbox/||"`
  echo ${x}
fi

if [ -d "$x" ];
then
  echo local repository exist!!!
else
  git clone -v "$1" "$x"
fi
