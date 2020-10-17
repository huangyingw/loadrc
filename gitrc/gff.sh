#!/bin/zsh
if [ -z "$1" ]
then
    echo -e "${red}Please provide the file name in full ... ${NC}"
    exit 1
fi

commit=`git log --all -- "$1" | awk 'NR==1{print $2}'`
if [ -z "$commit" ]
then
    echo -e "${red}The file is not found ... ${NC}"
    exit 1
fi
echo "$commit"
git branch --contains "$commit"

#for branch in $(git rev-list --all)
#do
#  git ls-tree -r --name-only $branch | grep "$1" | sed 's/^/'$branch': /'
#done
#http://stackoverflow.com/questions/372506/how-can-i-search-git-branches-for-a-file-or-directory
