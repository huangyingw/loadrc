#!/bin/zsh

if [ ! -f .gitconfig ]
then
    exit 0
fi

config=$(~/loadrc/gitrc/get_git.sh)
relative_path=$(python3 -c "import os.path; print(os.path.relpath('.gitconfig', '${config}'))")
git config --local include.path $relative_path
