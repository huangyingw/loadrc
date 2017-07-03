#!/bin/bash -
svn st | tee svnst.findresult

sed -i.bak "/^?/d" svnst.findresult
sed -i.bak "/^$/d" svnst.findresult
sed -i.bak "/Changelist/d" svnst.findresult
sed -i.bak "s/\b[M]\b/svn revert $1/g" svnst.findresult
sort -u svnst.findresult -o svnst.findresult
