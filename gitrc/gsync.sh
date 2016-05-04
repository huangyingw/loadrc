#!/bin/bash
TARGET_BRANCH_DEFAULT=branch.default
if [ ! -f "$TARGET_BRANCH_DEFAULT" ];
then
  echo -e "${red}Please put the default sync branch in branch.default file... ${NC}"
  exit 1
fi
TARGET_BRANCH=$(cat "$TARGET_BRANCH_DEFAULT")
if [ -z "$TARGET_BRANCH" ]
then
  echo -e "${red}Please put the default sync branch in branch.default file... ${NC}"
  exit 1
fi
echo "$TARGET_BRANCH"
CURRENT_BRANCH="`git branch |awk '/^\*/{print $2}'`"
git checkout "$TARGET_BRANCH" \
  && ~/loadrc/gitrc/gpl.sh \
  && git checkout "$CURRENT_BRANCH" \
  && ~/loadrc/gitrc/gme.sh "$TARGET_BRANCH"
