#!/bin/zsh 
#===============================================================================
#
#          FILE: cleandocker.sh
# 
#         USAGE: ./cleandocker.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/17/2016 21:42
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
docker rmi -f $(docker images -a | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3)
