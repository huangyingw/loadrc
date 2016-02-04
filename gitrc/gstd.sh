#!/bin/bash
ready_file="gstv.ready"
if [ ! -f ${ready_file} ];
then
  echo -e "${red}gstv must be run before gstd first ... ${NC}"
  exit 1
fi
if [ -n "$1" ];
then
  git stash drop stash@{"$1"}
else
  git stash drop
fi
rm ${ready_file}
