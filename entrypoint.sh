#!/bin/bash

for ss in \
    bak \
    findresult \
    runresult \
    deps \
    diff \
    cache \
    git
do
    find . -name \*.$ss\*
done
