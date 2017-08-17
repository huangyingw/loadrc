#!/bin/bash
svn status | tee svnst.findresult 

while read ss
do
    sed -i.bak "/^.*.$ss\$/d" svnst.findresult
done < svnpostfix.ignore

while read ss
do
    ss=$(echo $ss | sed  -e "s/\//\\\\\//g")
    sed -i.bak "/$ss/d" svnst.findresult
done < svnfiles.ignore

sed -i.bak "/^$/d" svnst.findresult
sed -i.bak "s/\b[M]\b/svn cl utest $1/g" svnst.findresult
