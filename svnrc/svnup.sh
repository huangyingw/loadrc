#!/bin/zsh

if !(git status . | grep -q 'nothing to commit')
then
    echo -e "${red}the git repository is unclean, please check it before continuing... ${NC}"
    exit 1
fi

svn up

while IFS= read -r line
do
    git add $line
done < <( comm -23 <(git status --porcelain | awk '{print $2}') <(sort svn.diffiles) )
~/loadrc/gitrc/g.sh
