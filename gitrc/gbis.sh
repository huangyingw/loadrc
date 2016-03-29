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
#       CREATED: 03/29/2016 13:42
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

~/loadrc/gitrc/gbil.sh \
  && git bisect start
