#!/bin/bash 
if [ -z "$1" ];
then
  echo -e "${red}please provide the host name... ${NC}"
  exit 1
fi
OS=`uname`
if [ "$OS" == "Linux" ]
then
  umount ~/samba
else
  diskutil unmountDisk force ~/samba
fi
SERVER="$1"
. ~/loadrc/keys/getConDetails.sh "$SERVER"

if [ -z "$key" ];
then
  sshfs -o Ciphers=arcfour -o Compression=no "$user"@"$host":/ ~/samba
else
  sshfs -o Ciphers=arcfour -o Compression=no -o IdentityFile="$key" "$user"@"$host":/ ~/samba 
fi
df \
  && cd ~/samba \
  && echo -e "${green}$(pwd) ${NC}" "in"  "${green}$1 ${NC}"
