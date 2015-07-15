#!/bin/bash 
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if [ -z "$1" ];
then
  echo -e "${red}please provide the host name... ${NC}"
  exit 1
fi
ssh-keygen -R "$1" \
  && rsync -aH --force -e ssh ~/.ssh/ "$1":~/.ssh/ \
  && rsync -aH --force -e ssh ~/.ssh/ root@"$1":~/.ssh/ \
  && rsync -aHv --progress --delete --force -e ssh ~/loadrc/grub.d/ root@"$1":/etc/grub.d/ \
  && scp -v ~/loadrc/bashrc/ssh_host_* root@"$1":/etc/ssh/
