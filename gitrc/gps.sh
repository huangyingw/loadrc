#!/bin/bash
GPSDEFAULT=gps.default
if [ ! -f "$GPSDEFAULT" ];
then
  echo -e "${red}By default git push is disabled, please manually do it ... ${NC}"
  exit 0
fi
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; do git push -v $ss && git push -v --tag $ss; done
