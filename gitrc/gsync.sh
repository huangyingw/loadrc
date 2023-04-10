#!/bin/zsh

# Define variables
dogsync_script="$HOME/loadrc/gitrc/dogsync.sh"
git_submodule_status_cmd="git submodule status"
awk_cmd="awk '{print $2}'"
parallel_cmd="parallel --jobs 0 --ungroup"

# Execute the dogsync script
source "$dogsync_script"

# Execute the dogsync script for each submodule
$git_submodule_status_cmd | $awk_cmd | $parallel_cmd "cd {}; source $dogsync_script; cd -"
