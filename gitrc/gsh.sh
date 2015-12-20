#!/bin/bash
if [ -z "$1" ];
then
  echo -e "${red}please specify the file name ... ${NC}"
  exit 0
fi
commits=( $(git log --oneline --format=%H --follow -- "$1") )
for (( i=0; i<${#commits[@]}; i++ )); do echo ${commits[i]};git difftool ${commits[i]}^! "$1"; done
