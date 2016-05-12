#!/bin/bash 
if [ -z "$1" ];
then
  echo -e "${red}please provide the host name... ${NC}"
  exit 1
fi
diskutil umount force ~/samba
SERVER="$1"
. ~/loadrc/bashrc/getConDetails.sh "$SERVER"

if [ $key == "/Users/huangyingw/loadrc/keys/.pem" ];
then
  sshfs "$user"@"$host":/ ~/samba
else
  sshfs -o "IdentityFile=""$key" "$user"@"$host":/ ~/samba 
fi
df \
  && cd ~/samba \
  && echo -e "${green}$(pwd) ${NC}" "in"  "${green}$1 ${NC}"
