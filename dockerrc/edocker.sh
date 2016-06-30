#!/bin/bash
CONTAINERID=$(docker ps|awk -v pat="$1" '$0 ~ pat { print $1}')
if [ $(docker ps -q|wc -l) -eq 1 ];
then
  CONTAINERID=$(docker ps -q)
fi
if [ -z "$CONTAINERID" ];
then
  echo -e "${red}Must provide the image name... ${NC}"
  exit 1
fi
docker exec \
  -it "$CONTAINERID" bash
