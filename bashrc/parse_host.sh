#!/bin/zsh

echo "$1" | sed 's/^[^:]*$/localhost/g;s/\([^:]*\):.*$/\1/g'  
