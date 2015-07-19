#!/bin/bash 
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color
if [ -z "$1" ];
then
  echo -e "${red}please provide the host name... ${NC}"
  exit 1
fi
diskutil umount force ~/samba \
  ; sshfs root@"$1":/ ~/samba \
  && df \
  && cd ~/samba \
  && echo -e "${green}$(pwd) ${NC}" "in"  "${green}$1 ${NC}"
