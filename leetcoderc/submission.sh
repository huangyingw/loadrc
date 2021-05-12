#!/bin/zsh
NUM="$1"
mkdir -p ../downloads/"$NUM"/ 
leetcode submission "$NUM" -o ../downloads/"$NUM"/
