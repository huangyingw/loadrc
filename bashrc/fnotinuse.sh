#!/bin/bash - 
#===============================================================================
#
#          FILE: fnotinuse.sh
# 
#         USAGE: ./fnotinuse.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/29/2016 11:08
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
while read suf
do
  echo "$suf"
done < '/export/home1/username/cscope_db/'`pwd |sed -e "s/^.*\///g"` 
