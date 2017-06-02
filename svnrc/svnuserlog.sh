#!/bin/bash -
svn log | sed -n '/yhuang/,/-----$/ p'
