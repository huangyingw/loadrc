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
commit_message_file="$git_directory/COMMIT_EDITMSG"
commit_message=$(cat "$commit_message_file")

# Check if the COMMIT_EDITMSG file is older than 30 minutes
current_time=$(date +%s)

# Detect the operating system
os=$(uname)

# Get the file modification time based on the operating system
if [[ "$os" == "Linux" ]]; then
    file_modification_time=$(stat -c %Y "$commit_message_file")
elif [[ "$os" == "Darwin" ]]; then
    file_modification_time=$(stat -f %m "$commit_message_file")
else
    echo -e "${red}Unsupported operating system...${NC}"
    exit 1
fi

time_diff=$((current_time - file_modification_time))
time_limit=$((30 * 60))

if [ $time_diff -gt $time_limit ]; then
    echo -e "${red}COMMIT_EDITMSG is older than 30 minutes. Please update the commit message...${NC}"
    exit 1
fi

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
git apply --reject --whitespace=fix --recount --index "$gdit_diff"

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
    git push "$remote" "$target_branch"
fi
