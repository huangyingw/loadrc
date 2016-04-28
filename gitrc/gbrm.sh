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

set -o nounset                              # Treat unset variables as an error

if [ -z "$1" ];
then
  echo -e "${red}please provide the new branch name... ${NC}"
  exit 1
fi

CURRENT_BRANCH="`git branch |awk '/^\*/{print $2}'`"
NEW_BRANCH="$1"

git branch -m "$CURRENT_BRANCH" "$NEW_BRANCH"

if [ -f dropbox.only ];
then
  git push -u dropbox "$CURRENT_BRANCH":"$NEW_BRANCH"
  exit 0
fi
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`
do 
  git push -u $ss "$CURRENT_BRANCH":"$NEW_BRANCH"
done
