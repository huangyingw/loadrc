#!/bin/bash 
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if [ -z "$1" ];
then
  echo -e "${red}please specify the target server ... ${NC}"
  exit 1
fi

TARGET=$1
rsync -e ssh -aHv --progress --delete-during --force ~/Library/Application\ Support/Firefox/ "${TARGET}":~/Library/Application\ Support/Firefox/
rsync -e ssh -aHv --progress --delete-during --force ~/Library/Caches/Firefox/Profiles/d6ekdgot.default/ "${TARGET}":~/Library/Caches/Firefox/Profiles/d6ekdgot.default/
