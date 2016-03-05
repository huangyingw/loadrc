#!/bin/bash
git branch -D $1
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; do git push $ss :$1; done
