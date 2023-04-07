#!/bin/sh

# Initialize the git submodules
git submodule init

# Get submodule path information from the .gitmodules file
git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |

# Process each submodule
while read submodule_path_key submodule_path; do
    # Extract the submodule name from the submodule path key
    submodule_name=$(echo $submodule_path_key | sed 's/\submodule\.\(.*\)\.path/\1/')

    # Create submodule URL and branch keys based on the submodule name
    submodule_url_key=$(echo $submodule_path_key | sed 's/\.path/.url/')
    submodule_branch_key=$(echo $submodule_path_key | sed 's/\.path/.branch/')

    # Get submodule URL and branch values
    submodule_url=$(git config -f .gitmodules --get "$submodule_url_key")
    submodule_branch=$(git config -f .gitmodules --get "$submodule_branch_key" || echo "master")

    # Check if the submodule directory is empty (0B)
    submodule_directory_size=$(du -s "$submodule_path" | cut -f1)

    if [ "$submodule_directory_size" -eq 0 ]; then
        # Remove the empty submodule directory
        rm -rf "$submodule_path"

        # Remove the submodule from the index
        git rm --cached "$submodule_path"

        # Commit the removal of the submodule
        git commit -m "Remove empty submodule $submodule_name"
    fi

    # Check if the submodule is already in the index
    submodule_index_status=$(git ls-files --stage -- "$submodule_path" | grep -E '^160000')

    if [ -z "$submodule_index_status" ]; then
        # Add the submodule with the specified branch, URL, and path
        git submodule add -b $submodule_branch $submodule_url $submodule_path || continue
    fi
done
