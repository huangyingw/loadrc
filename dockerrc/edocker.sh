#!/bin/bash
if [ $(docker ps -q|wc -l) -gt 1 ];
then
  if [ -z "$1" ];
  then
    echo -e "${red}Must provide the containder ID... ${NC}"
    exit 1
  else
    CONTAINERID="$1"
  fi
else
  CONTAINERID=$(docker ps -q)
fi
docker exec \
  -it "$CONTAINERID" bash
