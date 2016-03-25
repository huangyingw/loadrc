#!/bin/bash - 
#===============================================================================
#
#          FILE: gvlg.sh
# 
#         USAGE: ./gvlg.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/23/2016 12:46
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
COMMIT="$1"
git difftool "$COMMIT"^! 
