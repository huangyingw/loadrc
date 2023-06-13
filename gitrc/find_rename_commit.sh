#!/usr/bin/env zsh

old_file_name="rsync_content_migrator.zsh"

echo "Looking for the commit where the file was renamed..."

# Get all commit hashes
commits=$(git rev-list --all)

for commit in ${(f)commits}
do
    # Check if the old file name is in the rename section of the commit's changes
    rename_info=$(git diff-tree --no-commit-id --name-status -r $commit | grep ^R.*$old_file_name)

    if [ -n "$rename_info" ]
    then
        new_file_name=$(echo $rename_info | cut -d ' ' -f 3)
        echo "File was renamed in commit $commit"
        echo "New file name: $new_file_name"
        echo "Details of the commit:"
        git show --name-status $commit
        exit 0
    fi
done

echo "No commit found where
