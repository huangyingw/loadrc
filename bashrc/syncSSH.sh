#!/bin/bash 
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if [ -z "$1" ];
then
  echo -e "${red}please provide the host name... ${NC}"
  exit 1
fi
rsync -aH --force -e ssh ~/.ssh/ root@"$1":~/.ssh/ \
  && scp -v ~/loadrc/bashrc/ssh_host_* root@"$1":/etc/ssh/
