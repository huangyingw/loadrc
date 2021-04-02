#!/bin/zsh
git remote update
git branch -a --no-merged | tee gbra.findresult
