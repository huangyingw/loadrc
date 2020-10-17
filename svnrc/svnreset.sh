#!/bin/zsh
resultFile="svnreset.findresult"
svn status | tee "$resultFile"

while read ss
do
    sed -i.bak "/^.*.$ss\$/d" "$resultFile"
done < svnpostfix.ignore

while read ss
do
    ss=$(echo $ss | sed  -e "s/\//\\\\\//g")
    sed -i.bak "/$ss/d" "$resultFile"
done < svn.diffiles

while read ss
do
    ss=$(echo $ss | sed  -e "s/\//\\\\\//g")
    sed -i.bak "/$ss/d" "$resultFile"
done < svnfiles.ignore

sed -i.bak "/^?/d" "$resultFile"
sed -i.bak "/^$/d" "$resultFile"
sed -i.bak "/Changelist/d" "$resultFile"
sed -i.bak "s/\b[MD]\b/svn revert $1/g" "$resultFile"
sed -i.bak "s/^!/svn revert $1/g" "$resultFile"
sed -i.bak "s/\b[A]\b/rm $1/g" "$resultFile"
sort -u "$resultFile" -o "$resultFile"
