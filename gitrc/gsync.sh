#!/bin/bash
if [ -z "$1" ];
then
  echo -e "${red}Must provide the target branch ... ${NC}"
  exit 1
fi
CURRENT_BRANCH="`git branch |awk '/^\*/{print $2}'`"
TARGET_BRANCH="$1"
git checkout "$TARGET_BRANCH" \
  && ~/loadrc/gitrc/gpl.sh \
  && git checkout "$CURRENT_BRANCH" \
  && ~/loadrc/gitrc/gme.sh "$TARGET_BRANCH"
