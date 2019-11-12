#!/bin/zsh -
git checkout files.proj ; git bisect good
git bisect log | tee gbil.log
