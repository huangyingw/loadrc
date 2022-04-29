#!/bin/zsh
~/loadrc/gitrc/discard_unnecessaries.sh
git bisect skip
git bisect log | tee gbil.log
