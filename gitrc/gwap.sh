#!/bin/bash -
git diff -w --no-color | git apply --cached --ignore-whitespace && git checkout -- . && git reset
