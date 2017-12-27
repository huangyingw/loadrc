#!/bin/bash -
#===============================================================================
#
#          FILE: gbrc.sh
#
#         USAGE: ./gbrc.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 04/28/2016 15:06
#      REVISION:  ---
#===============================================================================

if [ -z "$1" ]
then
    echo -e "${red}please provide the new branch name... ${NC}"
    exit 1
fi

CURRENT_BRANCH="`git branch |awk '/^\*/{print $2}'`"
NEW_BRANCH="$1"

git branch -m "$CURRENT_BRANCH" "$NEW_BRANCH"
