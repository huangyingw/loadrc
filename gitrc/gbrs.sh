#!/bin/zsh
git remote update
git branch -a --no-merged --sort=-committerdate | tee gbrs.findresult 
