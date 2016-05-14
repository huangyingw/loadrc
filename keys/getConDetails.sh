#!/bin/bash - 
SOURCE="$1" 
host=${SOURCE%:*}  
folder=${SOURCE##*:}

mapFILE="$HOME/loadrc/keys/keymap.csv"
KEYFOLDER="$HOME/loadrc/keys/"
key="$(cat ${mapFILE} |awk -F',' '/'"$host"'/{print $2}')"
if [ -n "$key" ];
then
  key="$KEYFOLDER""$key"".pem"
  chmod 400 "$key"
fi
user="$(cat ${mapFILE} |awk -F',' '/'"$host"'/{print $3}')"
