#!/bin/bash - 
#===============================================================================
#
#          FILE: sload.sh
# 
#         USAGE: ./sload.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 05/20/2016 00:00
#      REVISION:  ---
#===============================================================================

if ping -c 1 macpro &> /dev/null
then
  sshfs -o nonempty huangyingw@macpro:/Users/huangyingw/Dropbox/loadrc/ ~/loadrc/
  df -TH
  . $HOME/loadrc/.loadrc
else
  . $HOME/loadrc/.loadrc
fi
