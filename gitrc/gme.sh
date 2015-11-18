#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color

GMEDEFAULT=gme.default
if [ ! -f "$GMEDEFAULT" ];
then
  echo -e "${red}git merge is not allowed, without tag file: gme.default ... ${NC}"
  exit 1
fi
git merge "$1"
