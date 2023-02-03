#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

resultFile="/Users/yhuang/Dropbox/loadrc/loadrc.findresult"
cat "$resultFile" | wc -l
./get_first_column_of_file.sh "$resultFile"
cat "$resultFile" | wc -l
