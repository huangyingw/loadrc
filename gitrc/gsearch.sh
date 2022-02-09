#!/bin/zsh

git log --binary --ignore-all-space --ignore-blank-lines --ignore-cr-at-eol --ignore-space-at-eol --ignore-space-change -p -G "$1" &> "$2"
# git log --binary --ignore-all-space --ignore-blank-lines --ignore-cr-at-eol --ignore-space-at-eol --ignore-space-change -p master -G "property\(" --author="Ying Huang <yhuang@imvu.com>" --since="2017-08-15" -- rest/service > diff1.log
