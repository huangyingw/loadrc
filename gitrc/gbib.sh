#!/bin/zsh
~/loadrc/gitrc/discard_unnecessaries.sh
git bisect bad
git bisect log | tee gbil.log
