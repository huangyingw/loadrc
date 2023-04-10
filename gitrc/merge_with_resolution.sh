#!/bin/zsh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <branch-to-merge>"
    exit 1
fi

BRANCH_TO_MERGE="$1"

# Attempt to merge
MERGE_OUTPUT=$(git merge "$BRANCH_TO_MERGE" --strategy ort 2>&1)

# Check if merge failed due to conflicts
if [[ $MERGE_OUTPUT == *"error:"* ]]; then
    # Parse conflicting file names from merge output
    CONFLICTING_FILES=$(echo "$MERGE_OUTPUT" | grep -oP '(?<=        ).*(?=\n)')

    # Rename conflicting files to *.bak
    for FILE in ${(f)CONFLICTING_FILES}; do
        mv "$FILE" "${FILE}.bak"
    done

    # Merge again
    git merge "$BRANCH_TO_MERGE" --strategy ort
else
    echo "Merge completed without conflicts."
fi
