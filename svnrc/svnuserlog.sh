#!/bin/zsh
svn log | sed -n '/yhuang/,/-----$/ p'
