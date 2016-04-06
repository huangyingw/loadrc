#!/bin/bash - 
#===============================================================================
#
#          FILE: mosh.sh
# 
#         USAGE: ./mosh.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/06/2016 09:42
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

mosh --ssh='ssh -i /Users/huangyingw/loadrc/keys/tg_h2h.pem' ubuntu@54.222.220.219 -- tmux attach || tmux new main
