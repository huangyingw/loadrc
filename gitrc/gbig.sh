#!/bin/zsh
~/loadrc/gitrc/discard_unnecessaries.sh
git bisect good
git bisect log | tee gbil.log
