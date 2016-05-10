#!/bin/bash 
if [ -z "$1" ];
then
  echo -e "${red}please provide the host name... ${NC}"
  exit 1
fi
diskutil umount force ~/samba
SERVER="$1"
KEY=$(~/loadrc/keys/getKey.sh "$SERVER")

if [ $KEY == "/Users/huangyingw/loadrc/keys/.pem" ];
then
  sshfs root@"$SERVER":/ ~/samba
else
  sshfs -o "IdentityFile=""$KEY" ubuntu@"$SERVER":/ ~/samba 
fi
df \
  && cd ~/samba \
  && echo -e "${green}$(pwd) ${NC}" "in"  "${green}$1 ${NC}"
