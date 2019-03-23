#!/bin/bash
git branch -d "$1"
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; \
do \
    git push $ss --delete "$1"; \
done
