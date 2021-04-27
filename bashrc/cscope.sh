#!/bin/zsh

SOURCEFILE="cscopesourcefile.bak"
CSCOPEFILE="cscopefile.bak"

cp -fv files.proj "$SOURCEFILE" && \
    sed -i.bak 's/\\ / /g' "$SOURCEFILE" && \
    cscope -bq -i "$SOURCEFILE" -f "$CSCOPEFILE" && \
    cp -fv "$CSCOPEFILE" cscope.out && \
    cp -fv "$CSCOPEFILE".in cscope.out.in && \
    cp -fv "$CSCOPEFILE".po cscope.out.po
