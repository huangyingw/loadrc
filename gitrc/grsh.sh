#!/bin/bash
git status | tee grsh.findresult

gsed -i.bak "s/deleted:/git checkout -- /g" grsh.findresult
gsed -i.bak "s/modified:/git checkout -- /g" grsh.findresult
gsed -i.bak 's/^[ \t]*//;s/[ \t]*$//' grsh.findresult
gsed -i.bak '/^git /!d' grsh.findresult
sort -u grsh.findresult -o grsh.findresult
