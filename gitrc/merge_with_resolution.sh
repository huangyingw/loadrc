#!/bin/zsh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <branch-to-merge>"
    exit 1
fi

BRANCH_TO_MERGE="$1"

# Attempt to merge
MERGE_OUTPUT=$(git merge "$BRANCH_TO_MERGE" --strategy ort 2>&1)

# Check if merge failed due to untracked files or local changes
if [[ $MERGE_OUTPUT == *"error:"* ]]; then
    if [[ $MERGE_OUTPUT == *"untracked working tree files would be overwritten by merge"* ]]; then
        echo "Untracked working tree files would be overwritten by merge. Renaming them to *.bak."

        # Abort the merge
        git merge --abort

        # Parse untracked file names from merge output
        UNTRACKED_FILES=$(echo "$MERGE_OUTPUT" | awk '/^error: The following untracked working tree files would be overwritten by merge:/,/^Please move or remove them before you merge./' | awk '/^\t/ {print substr($0, 2)}' | awk '{$1=$1};1')

        # Rename untracked files to *.bak
        for FILE in ${(f)UNTRACKED_FILES}; do
            mv "$FILE" "${FILE}.bak"
        done

        # Attempt the merge again
        MERGE_OUTPUT=$(git merge "$BRANCH_TO_MERGE" --strategy ort 2>&1)
    fi

    if [[ $MERGE_OUTPUT == *"local changes to the following files would be overwritten by merge"* ]]; then
        echo "Local changes would be overwritten by merge. Discarding local changes and continuing."

        # Discard local changes using the provided script
        ~/loadrc/gitrc/discard_unnecessaries.sh

        # Attempt the merge again
        MERGE_OUTPUT=$(git merge "$BRANCH_TO_MERGE" --strategy ort 2>&1)
    fi

    if [[ $MERGE_OUTPUT == *"error:"* ]]; then
        echo "Merge failed with the following output:"
        echo "$MERGE_OUTPUT"
    else
        echo "Merge completed successfully."
    fi
else
    echo "Merge completed without conflicts."
fi
