#!/bin/bash - 
rsync -aHv --force --delete --progress \
  --exclude-from="excludeFile" \
  "$1" \
  "$2"
