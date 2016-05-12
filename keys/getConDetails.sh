#!/bin/bash - 
SOURCE="$1" 

DOMAIN=${SOURCE%:*}  # get the part before the colon
user=${DOMAIN%@*}  
host=${DOMAIN##*@}
key=$(~/loadrc/keys/getKey.sh "$host")
if [ $user == $host ];
then
  if [ $key == "/Users/huangyingw/loadrc/keys/.pem" ];
  then
    user="root"
  else
    user="ubuntu"
  fi
fi
