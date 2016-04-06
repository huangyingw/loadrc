#!/bin/bash - 
#===============================================================================
#
#          FILE: getKey.sh
# 
#         USAGE: ./getKey.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/05/2016 15:21
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

server="$1"
KEYFILE="$HOME/loadrc/keys/keymap"
KEYFOLDER="$HOME/loadrc/keys/"
key=$(cat ${KEYFILE} |awk -F'=' '/'"$server"'/{print $2}')
echo "$KEYFOLDER""$key"".pem"
