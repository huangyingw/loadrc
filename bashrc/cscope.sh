#!/bin/zsh

cscope -bq -i files.proj -f cscope.out.bak && \
    cp -fv cscope.out.bak cscope.out && \
    cp -fv cscope.out.bak.in cscope.out.in && \
    cp -fv cscope.out.bak.po cscope.out.po
