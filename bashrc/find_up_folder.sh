#!/bin/zsh

rpath="$1"

# 如果路径以 "fugitive://" 开头，则去除这部分
rpath=${rpath#fugitive://}

while [[ "$rpath" != "" && "$rpath" != "/" && ! -e "$rpath/$2" ]]
do
    rpath=${rpath%/*}
done

echo "$rpath"
