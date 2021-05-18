#!/bin/zsh
git remote update
git branch --sort=-committerdate -a --no-merged | tee gbra.log
