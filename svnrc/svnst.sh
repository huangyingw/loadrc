#!/bin/bash
svn status | sed -e '/^.*.\(findresult\|orig\|sw.\|bak\|default\)$/d' |sed -e '/\(files.proj\|.gitignore\|includefile.conf\|prunefile.conf\|prunefix.conf\)/d' | tee svnst.findresult 
sed -i.bak "/^$/d" svnst.findresult
sed -i.bak "s/\b[M]\b/svn cl utest $1/g" svnst.findresult
