#!/bin/zsh
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

if ( echo "$currentBranch" | grep -q 'fix$' )
then
    echo -e "${red}gfix should not be run in fix branch ... ${NC}"
    exit 1
fi

fix_branch=`git branch |awk '/^\*/{print $2}'`.fix

if ( git branch|grep -q "$fix_branch" )
then
    ~/loadrc/gitrc/discard_unnecessaries.sh
    git checkout "$fix_branch"
    exit 0
fi

git checkout -b "$fix_branch"
