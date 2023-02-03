#!/bin/zsh
targetFile="$1"
keyWord="$2"
sed -i.bak '/'"$keyWord"'/,$!d' $targetFile
tail -r $targetFile | sed '/'"$keyWord"'/,$!d' | tail -r > $targetFile.findresult \
  && cp -f $targetFile.findresult $targetFile
