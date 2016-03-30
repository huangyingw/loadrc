#!/bin/bash - 
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
# Delete all containers
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
# Delete all images
docker images|awk '/<none>/{print $3}'|sed 's/sha256://g'|while read ss; 
do 
  docker rmi -f "$ss";
done
