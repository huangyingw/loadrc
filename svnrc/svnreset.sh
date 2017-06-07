#!/bin/bash -
svn st | tee svnst.findresult

OS=`uname`
if [ "$OS" == "Linux" ]
then
    sed -i.bak "/^?/d" svnst.findresult
    sed -i.bak "/^$/d" svnst.findresult
    sed -i.bak "/Changelist/d" svnst.findresult
    sed -i.bak "s/\b[M]\b/svn revert $1/g" svnst.findresult
else
    sed -i.bak "s/[[:<:]]D[[:>:]]/git rm/g" svnst.findresult
    sed -i.bak "s/[[:<:]][AMT][[:>:]]/git checkout $1 -- /g" svnst.findresult
    sed -i.bak "s/^R[0-9]*/git mv/g" svnst.findresult
fi
sort -u svnst.findresult -o svnst.findresult
