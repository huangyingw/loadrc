#!/bin/zsh

if [ ! -f files.proj ]
then
    echo -e "${red}No files.proj file here, will not update the proj ... ${NC}"
    exit 1
fi

~/loadrc/bashrc/check_running.sh ~/loadrc/bashrc/do_update_proj.sh
