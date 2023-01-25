#!/bin/zsh
git remote update
git branch --sort=-committerdate -a --no-merged | tee gbr.log
sed -i.bak 's/[[:space:]]*remotes\///g;s/[[:space:]]*//g' gbr.log
