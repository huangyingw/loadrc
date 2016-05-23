#!/bin/bash - 
SOURCE="$1"
TARGET="$2"
INCLUDEFROM="includeFrom"
rsync -aHinv --delete-during --force \
  --include="*/" --include-from="$INCLUDEFROM"  --exclude="*" \
  "${SOURCE}" "${TARGET}" | tee selectCopy.findresult
