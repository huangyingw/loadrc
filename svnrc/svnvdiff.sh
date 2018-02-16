#!/bin/bash
svn status | tee svnvdiff.findresult

while read ss
do
    sed -i.bak "/^.*.$ss\$/d" svnvdiff.findresult
done < svnpostfix.ignore

while read ss
do
    ss=$(echo $ss | sed  -e "s/\//\\\\\//g")
    sed -i.bak "/$ss/d" svnvdiff.findresult
done < svnfiles.ignore

sed -i.bak "/^$/d" svnvdiff.findresult
sed -i.bak "/Changelist/d" svnvdiff.findresult
sed -i.bak "s/\b[A|D|M]\b/svn diff --diff-cmd kdiff3 $1/g" svnvdiff.findresult
sort -u svnvdiff.findresult -o svnvdiff.findresult
svn diff --cl utest > utest.diff
