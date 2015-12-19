#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color

GPSDEFAULT=gps.default
if [ ! -f "$GPSDEFAULT" ];
then
  echo -e "${red}By default git push is disabled, please manually do it ... ${NC}"
  exit 0
fi
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; do git push --all $ss && git push --tag $ss; done
