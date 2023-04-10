#!/bin/bash

BRANCH_TO_MERGE="<branch-to-merge>"

# Attempt to merge
MERGE_OUTPUT=$(git merge "$BRANCH_TO_MERGE" --strategy ort 2>&1)

# Check if merge failed due to conflicts
if [[ $MERGE_OUTPUT == *"error:"* ]]; then
    # Parse conflicting file names from merge output
    CONFLICTING_FILES=$(echo "$MERGE_OUTPUT" | grep -oP '(?<=        ).*(?=\n)')

    # Rename conflicting files to *.bak
    for FILE in $CONFLICTING_FILES; do
        mv "$FILE" "${FILE}.bak"
    done

    # Merge again
    git merge "$BRANCH_TO_MERGE" --strategy ort

    # Commit and push changes
    git add .
    git commit -m "Merged $BRANCH_TO_MERGE with resolution"
    git push
else
    echo "Merge completed without conflicts."
fi
