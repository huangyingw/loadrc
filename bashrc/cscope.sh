#!/bin/zsh

CSCOPEFILE="cscopefile.bak"
cscope -bq -i files.proj -f "$CSCOPEFILE" && \
    cp -fv "$CSCOPEFILE" cscope.out && \
    cp -fv "$CSCOPEFILE".in cscope.out.in && \
    cp -fv "$CSCOPEFILE".po cscope.out.po
