#!/bin/bash

for ss in \
    bak \
    findresult \
    git
do
    find . -name \*.$ss\*
done
