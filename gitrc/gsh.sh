#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if [ -z "$1" ];
then
  echo -e "${red}please specify the file name ... ${NC}"
  exit 0
fi
git log --follow "$1"|awk '/commit/{print $2}'|while read ss; do git difftool $ss^! "$1"; done
