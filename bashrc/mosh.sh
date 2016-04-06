#!/bin/bash - 
#===============================================================================
#
#          FILE: mosh.sh
# 
#         USAGE: ./mosh.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/06/2016 09:42
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

SERVER="$1"
KEY=$(~/loadrc/keys/getKey.sh "$SERVER")

if [ $KEY == "/Users/huangyingw/loadrc/keys/.pem" ];
then
  mosh "$SERVER" -- tmux new-session -A -s main 
else
  mosh --ssh='ssh -i '"$KEY" ubuntu@"$SERVER" -- tmux new-session -A -s main
fi
