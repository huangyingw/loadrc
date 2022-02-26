#!/bin/bash

for ss in \
    bak \
    findresult \
    git
do
    echo $ss
    find . -name \*.$ss\*
done
