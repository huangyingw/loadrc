#!/bin/zsh
resultFile="svnst.findresult"
svn status | tee "$resultFile"

while read ss
do
    sed -i.bak "/^.*.$ss\$/d" "$resultFile"
done < svnpostfix.ignore

while read ss
do
    ss=$(echo $ss | sed  -e "s/\//\\\\\//g")
    sed -i.bak "/$ss/d" "$resultFile"
done < svnfiles.ignore

sed -i.bak "/^$/d" "$resultFile"
sed -i.bak "s/\b[M]\b/svn cl utest $1/g" "$resultFile"
~/loadrc/svnrc/svnvdiff.sh
svn diff -x -w --cl utest > svn.diff
