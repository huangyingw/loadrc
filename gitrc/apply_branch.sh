#!/bin/zsh
BRANCH="$1"
BRANCH=$(echo "$BRANCH" | sed 's/remotes\///g')
BRANCH_DIFF=$(echo "$BRANCH" | sed 's/[^\/]*\///g')
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
    git checkout "$BRANCH" "$targetFile" && \
        rm "$ss"
done
