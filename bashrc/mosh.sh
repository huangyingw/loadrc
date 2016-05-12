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
. ~/loadrc/bashrc/getConDetails.sh "$SERVER"
echo $user
echo $host

if [ $key == "/Users/huangyingw/loadrc/keys/.pem" ];
then
  echo mosh "$user"@"$host" -- ${tmuxAction}
else
  echo mosh --ssh='ssh -i '"$key" "$user"@"$host" -- ${tmuxAction}
fi
