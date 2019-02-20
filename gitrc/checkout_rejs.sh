#!/bin/bash
for ss in $(git st|grep .*\.rej$) ; \
do \
    git checkout "$1" $(echo "$ss" | sed 's/\.rej$//g') && \
    rm "$ss" ; \
done
