#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

rm -fr lib
./ln_fs.sh /var/lib lib
ls -al lib
echo

rm lib
mkdir lib
./ln_fs.sh /var/lib lib
ls -al lib
echo

rm lib
touch lib
./ln_fs.sh /var/lib lib
ls -al lib
echo

rm lib
ln -fs /var/lib lib
./ln_fs.sh /var/lib lib
ls -al lib
echo
