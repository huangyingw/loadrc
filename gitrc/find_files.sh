#!/bin/bash -
fileName=$(grep  $1 files.proj | sed -e 's/"//g')
echo "$fileName"
