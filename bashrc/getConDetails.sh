#!/bin/bash - 
SOURCE="$1" 

DOMAIN=${SOURCE%:*}  # get the part before the colon
user=${DOMAIN%@*}  
host=${DOMAIN##*@}
key=$(~/loadrc/keys/getKey.sh "$host")
if [ $user == $host ];
then
  user="root"
fi
