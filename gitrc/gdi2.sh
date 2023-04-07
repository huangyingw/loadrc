#!/bin/zsh

# Get the current branch
current_branch=$(~/loadrc/gitrc/get_current_branch.sh)

# Check if the current branch is a "*.fix" branch
if [[ "$current_branch" != *".fix" ]]; then
    echo -e "${red}This script should only run in a *.fix branch...${NC}"
    exit 1
fi

# Get Git directory and commit message
git_directory=$(git rev-parse --git-dir)
commit_message=$(cat "$git_directory/COMMIT_EDITMSG")

# Determine the target branch
target_branch=$(echo "$current_branch" | sed 's/\.fix$//g')

# Check if gsync.target is configured
if [ -z $(git config gsync.target) ]; then
    echo -e "${red}gsync.target is not configured...${NC}"
fi

# Get the remote repository
remote="$(git config gdi2.remote)"

# Push to the remote target branch
git push "$remote" "$target_branch"

# Create the diff file name
gdit_diff=$(echo "$current_branch.gdit.diff" | sed 's/\//_/g')

# Check if the diff file is empty
if [ -z $(cat $gdit_diff) ]; then
    exit 0
fi

# Discard unnecessary changes and apply the patch
~/loadrc/gitrc/discard_unnecessaries.sh
git checkout -f "$target_branch"
git apply --reject --whitespace=fix --recount --allow-empty --index "$gdit_diff"

ret_val=$?

# Check if the patch was applied successfully
if [ $ret_val -ne 0 ]; then
    ~/loadrc/gitrc/checkout_rejs.sh "$current_branch" "$1"
fi

# Commit and push changes if conditions are met
if [ $ret_val -eq 0 ] || [ "$1" = "f" ] || [ $(git config checkoutrejs.force) ]; then
    if [ -z "$commit_message" ]; then
        echo -e "${red}Must provide the commit message...${NC}"
        echo -e "${red}Please edit COMMIT_EDITMSG to provide commit message...${NC}"
        exit 1
    fi

    git commit  --no-verify -am "$commit_message"
    git pull
    ~/loadrc/gitrc/gfix.sh
    echo > COMMIT_EDITMSG
    git push "$remote" "$target_branch"
fi
