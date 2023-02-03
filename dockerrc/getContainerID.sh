#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

if [ $(docker ps -q|wc -l) -eq 1 ]
then
  CONTAINERID=$(docker ps -q)
elif [ -n "$1" ]
then
  CONTAINERID=$(docker ps|awk -v pat="$1" '$0 ~ pat { print $1}')
fi
if [ -z "$CONTAINERID" ]
then
  echo -e "${red}Must provide the image name... ${NC}"
  exit 1
fi
