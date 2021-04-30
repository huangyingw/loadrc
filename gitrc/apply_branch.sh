#!/bin/zsh
BRANCH="$1"
BRANCH=$(echo "$BRANCH" | sed 's/remotes\///g')
BRANCH_DIFF=$(echo "$BRANCH" | sed 's/[^\/]*\///g')
BRANCH_DIFF="$BRANCH_DIFF.gdio.diff"
echo "BRANCH --> $BRANCH"
echo "BRANCH_DIFF --> $BRANCH_DIFF"

echo git show "$BRANCH":"$BRANCH_DIFF" > "$BRANCH_DIFF"
git show "$BRANCH":"$BRANCH_DIFF" > "$BRANCH_DIFF"
retVal=$?

if [ $retVal -ne 0 ]
then
    exit $retVal
fi

echo ~/loadrc/gitrc/reapply.sh "BRANCH_DIFF"
