#!/bin/bash
if !(git status "$folderForGit" | grep -q 'nothing to commit')
then
    echo -e "${red}the git repository is unclean, please check it before continuing... ${NC}"
    exit 1
fi

svn up | tee svnup.findresult
git st
