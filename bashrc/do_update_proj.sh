#!/bin/zsh

# Define the list of commands to run in parallel
commands=(
    "~/loadrc/bashrc/generate_files_proj.sh"
    "~/loadrc/bashrc/generate_rsync_files.sh"
    "~/loadrc/bashrc/fvideos.sh"
    "~/loadrc/bashrc/fdocs.sh"
    "~/loadrc/bashrc/cscope.sh"
    "git remote update"
)

# Run the commands in parallel with 10 jobs and keep the output in order
parallel --jobs 10 -k -- ::: "${commands[@]}"
