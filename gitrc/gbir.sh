#!/bin/bash -
#===============================================================================
#
#          FILE: gbir.sh
#
#         USAGE: ./gbir.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 03/29/2016 13:24
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ ! -f gbil.findresult ]
then
    echo -e "${red}Must run with gbil.findresult file... ${NC}"
    exit 1
fi
git bisect replay gbil.findresult \
    && git bisect log | tee gbil.findresult
