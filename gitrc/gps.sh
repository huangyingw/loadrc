#!/bin/bash
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; do git push --all $ss && git push --tag $ss; done
