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
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`
do 
  git pull $ss $TARGET_BRANCH
done
