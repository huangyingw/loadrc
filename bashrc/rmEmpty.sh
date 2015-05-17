#!/bin/bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0;0m' # No Color

if [ -z "$1" ];
then
  TARGETEDIR=.
else
  TARGETEDIR="$1"
fi

find "$TARGETEDIR" -type d -depth -empty -exec rmdir "{}" \;
