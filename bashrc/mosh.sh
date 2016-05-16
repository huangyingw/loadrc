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

~/loadrc/bashrc/smount.sh "$1" &
SERVER="$1"
. ~/loadrc/keys/getConDetails.sh "$SERVER"

if [ -z "$key" ];
then
  mosh "$user"@"$host" -- ${tmuxAction}
else
  mosh --ssh='ssh -i '"$key" "$user"@"$host" -- ${tmuxAction}
fi
