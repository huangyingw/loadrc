#!/bin/zsh - 
git checkout files.proj ; git bisect bad
git bisect log | tee gbil.log
