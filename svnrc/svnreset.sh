#!/bin/bash -
svn st | tee svnreset.findresult

sed -i.bak "/^?/d" svnreset.findresult
sed -i.bak "/^$/d" svnreset.findresult
sed -i.bak "/Changelist/d" svnreset.findresult
sed -i.bak "s/\b[M]\b/svn revert $1/g" svnreset.findresult
sort -u svnreset.findresult -o svnreset.findresult
