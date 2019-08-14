#!/bin/bash - 
#===============================================================================
#
#          FILE: gbib.sh
# 
#         USAGE: ./gbib.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/29/2016 14:13
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

git bisect bad
git bisect log | tee gbil.log
