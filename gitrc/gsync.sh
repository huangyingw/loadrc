#!/bin/zsh

# Define variables
dogsync_script="$HOME/loadrc/gitrc/dogsync.sh"

# Execute the dogsync script
source "$dogsync_script"

# Execute the dogsync script for each submodule
$(git submodule status) | $(awk '{print $2}') | $(parallel --jobs 10 --ungroup "cd {}; source $dogsync_script; cd -")
