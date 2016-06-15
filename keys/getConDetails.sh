#!/bin/bash - 
host="$1" 

mapFILE="$HOME/loadrc/keys/keymap.csv"
KEYFOLDER="$HOME/loadrc/keys/"
host="$(cat ${mapFILE} | awk -F',' -v pat="^$host" '$0 ~ pat { print $1}')"

if [ -z "$host" ];
then
  echo -e "${red}this host is not in the keymap.csv file ... ${NC}"
  exit 1
fi

key="$(cat ${mapFILE} | awk -F',' -v pat="^$host" '$0 ~ pat { print $2}')"
if [ -n "$key" ];
then
  key="$KEYFOLDER""$key"".pem"
  chmod 400 "$key"
fi
user="$(cat ${mapFILE} | awk -F',' -v pat="^$host" '$0 ~ pat { print $3}')"
