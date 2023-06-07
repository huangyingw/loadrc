#!/bin/zsh
currentBranch=$(~/loadrc/gitrc/get_current_branch.sh)

if ( echo "$currentBranch" | grep -q 'fix$' )
then
    echo -e "${red}gfix should not be run in fix branch ... ${NC}"
    exit 1
fi

fix_branch=`git branch |awk '/^\*/{print $2}'`.fix
~/loadrc/gitrc/gco.sh "$fix_branch"
