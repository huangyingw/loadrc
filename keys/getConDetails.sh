#!/bin/bash - 
SOURCE="$1" 

DOMAIN=${SOURCE%:*}  # get the part before the colon
host=${DOMAIN##*@}
key=$(~/loadrc/keys/getKey.sh "$host")
KEYFILE="$HOME/loadrc/keys/keymap.csv"
KEYFOLDER="$HOME/loadrc/keys/"
key=$(cat ${KEYFILE} |awk -F'=' '/'"$server"'/{print $2}')
echo "$KEYFOLDER""$key"".pem"
if [ -n ${DOMAIN%@*} ];
then
  user=${DOMAIN%@*}  
fi
if [ $user == $host ];
then
  if [ $key == "/Users/huangyingw/loadrc/keys/.pem" ];
  then
    user="root"
  else
    user="ubuntu"
  fi
fi
