#!/bin/bash - 
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

resultFile="/Users/yhuang/Dropbox/loadrc/vimrc.vim.findresult"
cat "$resultFile" | wc -l
./get_first_column_of_file.sh "$resultFile"
cat "$resultFile".bak | wc -l
