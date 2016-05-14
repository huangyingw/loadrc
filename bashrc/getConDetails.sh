#!/bin/bash - 
host="$1" 

mapFILE="$HOME/loadrc/keys/keymap.csv"
KEYFOLDER="$HOME/loadrc/keys/"
key="$KEYFOLDER""$(cat ${mapFILE} |awk -F',' '/'"$host"'/{print $2}')"".pem"
user="$(cat ${mapFILE} |awk -F',' '/'"$host"'/{print $3}')"
