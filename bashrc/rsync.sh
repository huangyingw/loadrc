#!/bin/bash - 
rsync -aHv --force --progress \
  --exclude-from="excludeFile" \
  "$1" \
  "$2"
