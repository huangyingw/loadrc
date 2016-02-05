#!/bin/bash 
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
