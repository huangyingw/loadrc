#!/bin/zsh

echo "$1" | sed '/:/!d;s/\([^:]*\):.*$/\1/g'  
