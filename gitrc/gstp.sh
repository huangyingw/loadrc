#!/bin/bash
fix_branch=`git branch |awk '/^\*/{print $2}'`
if ! (git status|grep -q 'nothing to commit')
then
  echo -e "${red}the git repository is unclean, please check it before continuing... ${NC}"
  exit 1
fi
top_branch=`git stash list|awk 'NR==v1 {print $4}' v1=$(($1+1)) |sed 's/://g'`
echo $top_branch
git branch |awk '/^\*/{print $2}'
~/loadrc/gitrc/gco.sh $top_branch
if [ -n "$1" ];
then
  git stash pop stash@{"$1"}
else
git stash pop
fi
