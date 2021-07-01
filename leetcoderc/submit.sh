#!/bin/zsh
find ~/.lc -type f -name problems.json -delete
find ~/myproject/git/interview/leetcode_solutions/ -type f -name "[0-9]*.py" | while read ss
do
    leetcode submit -d "$ss"
done
