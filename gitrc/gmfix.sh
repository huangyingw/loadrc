#!/bin/bash
fix_branch=`git branch |awk '/^\*/{print $2}'`
parent_branch=`echo ${fix_branch} | sed -e "s|.fix$||"` 
ready_file="gfvd.already"
if [ ! -f ${ready_file} ];
then
  echo -e "${red}gfvd must be run before gmfix first ... ${NC}"
  exit 1
fi
if  ( ! echo $fix_branch|grep -q 'fix$' )
then
  echo -e "${red}It must be run in fix branch ... ${NC}"
  exit 1
fi 
if  ( git status|grep -q 'nothing to commit' )
then
  git checkout "$parent_branch" \
    && ~/loadrc/gitrc/gme.sh "$fix_branch" \
    && git checkout "$fix_branch"
else
  git add . \
    && git stash|grep -q "HEAD is now at" \
    && git checkout "$parent_branch" \
    && ~/loadrc/gitrc/gme.sh "$fix_branch" \
    && git checkout "$fix_branch" \
    && git stash pop stash@{0} \
    && git reset HEAD . 
fi 
rm ${ready_file}
