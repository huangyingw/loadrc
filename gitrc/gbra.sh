#!/bin/zsh
git branch --sort=-committerdate -a | tee gbra.log
