#!/bin/bash - 
#===============================================================================
#
#          FILE: gbil.sh
# 
#         USAGE: ./gbil.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/29/2016 13:23
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

git bisect log | tee gbil.findresult
