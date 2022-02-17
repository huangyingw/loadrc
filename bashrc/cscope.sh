#!/bin/zsh

SOURCEFILE="cscopesourcefile.bak"
CSCOPEFILE="cscopefile.bak"

rsync -v files.proj "$SOURCEFILE" && \
    sed -i.bak 's/\\ / /g' "$SOURCEFILE" && \
    cscope -bq -i "$SOURCEFILE" -f "$CSCOPEFILE" && \
    rsync -v "$CSCOPEFILE" cscope.out && \
    rsync -v "$CSCOPEFILE".in cscope.out.in && \
    rsync -v "$CSCOPEFILE".po cscope.out.po
