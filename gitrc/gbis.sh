#!/bin/bash - 
#===============================================================================
#
#          FILE: gbis.sh
# 
#         USAGE: ./gbis.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/16/2016 10:40
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

git bisect skip
git bisect log | tee gbil.findresult
