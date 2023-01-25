#!/bin/zsh
git remote update
git branch --sort=-committerdate -a --no-merged | tee gbra.log
sed -i.bak 's/[[:space:]]*remotes\///g;s/[[:space:]]*//g' gbra.log
