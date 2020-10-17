#!/bin/zsh
svn status | tee svn.vdiff

while read ss
do
    sed -i.bak "/^.*.$ss\$/d" svn.vdiff
done < svnpostfix.ignore

while read ss
do
    ss=$(echo $ss | sed  -e "s/\//\\\\\//g")
    sed -i.bak "/$ss/d" svn.vdiff
done < svnfiles.ignore

sed -i.bak "/^$/d" svn.vdiff
sed -i.bak "/Changelist/d" svn.vdiff
sed -i.bak "s/\b[A|D|M]\b/svn diff --diff-cmd kdiff3 $1/g" svn.vdiff
sort -u svn.vdiff -o svn.vdiff

sed "s/svn diff --diff-cmd kdiff3        //g" svn.vdiff | tee svn.diffiles
sort -u svn.diffiles -o svn.diffiles
