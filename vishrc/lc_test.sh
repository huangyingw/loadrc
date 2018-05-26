#!/bin/bash -
fileName="$1"
cp -v ~/loadrc/vishrc/lc_test.template "$fileName.sh"
filenameVar=$(basename "$fileName")
echo $filename
sed -i.bak "s/filenameVar/$filenameVar/g" "$fileName.sh"
