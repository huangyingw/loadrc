#!/bin/bash
for ss in `git remote -v |awk '/\(fetch\)$/{print $1}'`; do git push -v $ss && git push -v --tag $ss; done
