#!/bin/zsh
xargs sed -e :a -e '/./,$!d;/^\n*$/{$d;N;};/\n$/ba' < files.proj
