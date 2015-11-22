#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color

~/loadrc/gitrc/gps.sh
GCIDEFAULT=gci.default
commit_message='n'
if [ -z "$1" ];
then
  if [ ! -f "$GCIDEFAULT" ];
  then
    echo -e "${red}Must provide the commit message ... ${NC}"
    exit 1
  fi
else
  commit_message="$1"
fi
git commit  --no-verify -m "$commit_message"
~/loadrc/gitrc/gps.sh
