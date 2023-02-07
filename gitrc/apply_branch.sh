#!/bin/zsh

git remote update

BRANCH="$1"
BRANCH=$(echo "$BRANCH" | sed 's/remotes\///g')
BRANCH_DIFF="$BRANCH"

for remote in $(git remote)
do
    BRANCH_DIFF=$(echo "$BRANCH_DIFF" | sed "s/^$remote\///g")
done

BRANCH_DIFF=$(echo "$BRANCH_DIFF" | sed 's/\//_/g')
BRANCH_DIFF="$BRANCH_DIFF.gdio.diff"
echo "BRANCH --> $BRANCH"
echo "BRANCH_DIFF --> $BRANCH_DIFF"

git show "$BRANCH":"$BRANCH_DIFF" > "$BRANCH_DIFF"
retVal=$?

if [ $retVal -ne 0 ]
then
    exit $retVal
fi

~/loadrc/gitrc/reapply.sh "$BRANCH_DIFF"

for ss in $(git status | grep \.rej$) ; \
do \
    targetFile=$(echo "$ss" | sed 's/\.rej$//g')
    git show "$BRANCH":"$targetFile" > "$targetFile" && \
        rm "$ss"
done
