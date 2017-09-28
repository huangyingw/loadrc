#!/bin/bash - 
currentBranch=`git branch --contains HEAD | grep -v HEAD | sed -e 's/^[* \t]*//'`
