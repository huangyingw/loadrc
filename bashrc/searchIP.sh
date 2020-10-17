#!/bin/zsh
#===============================================================================
#
#          FILE: searchIP.sh
#
#         USAGE: ./searchIP.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 05/19/2016 17:57
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

xargs grep -onHE -- "([0-9]{1,3}\.){3}[0-9]{1,3}" /dev/null < /export/home1/username/cscope_db/H2HSetup
