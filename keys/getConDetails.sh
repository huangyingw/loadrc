#!/bin/bash - 
user=
host=
key=
folder=

SOURCE="$1" 
host=${SOURCE%:*}  
folder=${SOURCE##*:}
if [ "$folder" == "$host" ];
then
  folder=
fi

mapFILE="$HOME/loadrc/keys/keymap.csv"
KEYFOLDER="$HOME/loadrc/keys/"
key="$(cat ${mapFILE} |awk -F',' '/'"$host"'/{print $2}')"
if [ -n "$key" ];
then
  key="$KEYFOLDER""$key"".pem"
  chmod 400 "$key"
fi
user="$(cat ${mapFILE} |awk -F',' '/'"$host"'/{print $3}')"
echo "origin --> ""$1"
echo "user --> ""$user"
echo "host --> ""$host"
echo "key --> ""$key"
echo "folder --> ""$folder"
