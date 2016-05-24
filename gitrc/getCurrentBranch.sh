#!/bin/bash - 
currentBranch=`git branch |awk '/\*/{print $2}'`
