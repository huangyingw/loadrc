#!/bin/bash -
if [ ! -f gbil.findresult ]
then
    echo -e "${red}Must run with gbil.findresult file... ${NC}"
    exit 1
fi
git bisect replay gbil.findresult \
    && git bisect log | tee gbil.findresult
