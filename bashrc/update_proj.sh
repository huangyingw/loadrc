#!/bin/zsh

if [ ! -f files.proj ]
then
    echo -e "${red}No files.proj file here, will not update the proj ... ${NC}"
    exit 1
fi

~/loadrc/bashrc/generate_files_proj.sh &
~/loadrc/bashrc/generate_rsync_files.sh &
~/loadrc/bashrc/fvideos.sh &
~/loadrc/bashrc/fdocs.sh &
~/loadrc/bashrc/cscope.sh &
git remote update &
