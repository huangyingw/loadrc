#!/bin/bash
current_branch=`git branch |awk '/^\*/{print $2}'`
if ( echo $current_branch|grep -q 'fix$' )
then
    echo -e "${red}gfix should not be run in fix branch ... ${NC}"
    exit 1
fi 
fix_branch=`git branch |awk '/^\*/{print $2}'`.fix
echo $fix_branch
if ( git branch|grep -q "$fix_branch" )
then
    git checkout "$fix_branch"
    exit 0
fi 
git checkout -b $fix_branch \
    && ~/loadrc/gitrc/gdev.sh $current_branch 
