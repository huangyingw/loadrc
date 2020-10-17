#!/bin/zsh
fileName="$1"

if [ -f "$fileName.sh" ]
then
    exit 0
fi

cp -v ~/loadrc/vishrc/lc_test.template "$fileName.sh"
filenameVar=$(basename "$fileName")
echo $filename
sed -i.bak "s/filenameVar/$filenameVar/g" "$fileName.sh"
