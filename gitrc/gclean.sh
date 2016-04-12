#!/bin/bash - 
#===============================================================================
#
#          FILE: gclean.sh
# 
#         USAGE: ./gclean.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/12/2016 15:07
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

git clean -fd
