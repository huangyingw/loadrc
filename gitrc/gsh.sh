#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if [ -z "$1" ];
then
  echo -e "${red}please specify the file name ... ${NC}"
  exit 0
fi
commits=( $(git log --follow "$1"|awk '/commit/{print $2}') )
for (( i=0; i<${#commits[@]}; i++ )); do git difftool ${commits[i]}^! "$1"; done
