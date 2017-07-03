#!/bin/bash
svn st | tee svnst.findresult

sed -i.bak "/^?/d" svnst.findresult
sed -i.bak "/^$/d" svnst.findresult
sed -i.bak "s/\b[M]\b/svn cl utest $1/g" svnst.findresult
