#!/bin/bash - 
#===============================================================================
#
#          FILE: binaryGrep.sh
# 
#         USAGE: ./binaryGrep.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 05/03/2016 16:12
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

grep -rnH --include *.tar \
  --include *.jar \
  "$1" \
  "$2"
