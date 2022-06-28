#!/bin/zsh

SOURCEFILE="cscopesourcefile.bak"

cp -fv files.proj "$SOURCEFILE" && \
    sed -i.bak 's/\\ / /g' "$SOURCEFILE" && \
    cscope -bq -i "$SOURCEFILE"
