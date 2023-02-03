#!/bin/zsh
git remote update
git branch --sort=-committerdate -a | tee gbra.log
