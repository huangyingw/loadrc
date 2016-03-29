#!/bin/bash - 
#===============================================================================
#
#          FILE: gbig.sh
# 
#         USAGE: ./gbig.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/29/2016 14:14
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

git bisect good
~/loadrc/gitrc/gbil.sh
