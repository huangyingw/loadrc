#!/bin/zsh

echo  /Users/huangyingw/loadrc/bashrc/cscope.sh >> ~/loadrc/g.findresult
SOURCEFILE="cscopesourcefile.bak"

cp -fv files.proj "$SOURCEFILE" && \
    sed -i.bak 's/\\ / /g' "$SOURCEFILE" && \
    cscope -bq -i "$SOURCEFILE"
