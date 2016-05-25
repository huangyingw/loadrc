#!/bin/bash
SYNC_BRANCH=$(git config branches.sync)
if [ -z "$SYNC_BRANCH" ]
then
  echo -e "${red}Please set the default sync branch in .git/config file... ${NC}"
  exit 1
fi
echo "$SYNC_BRANCH"
CURRENT_BRANCH="`git branch |awk '/^\*/{print $2}'`"
git checkout "$SYNC_BRANCH" \
  && ~/loadrc/gitrc/gpl.sh \
  ; git checkout "$CURRENT_BRANCH" \
  && ~/loadrc/gitrc/gme.sh "$SYNC_BRANCH" \
  && ~/loadrc/bashrc/cscope.sh
