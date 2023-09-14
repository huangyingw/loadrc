#!/bin/zsh

if [ ! -f files.proj ]
then
    echo -e "${red}No files.proj file here, will not update the proj ... ${NC}"
    exit 1
fi

if (~/loadrc/bashrc/check_remote_mounted.sh)
then
    echo -e "${red}running on remote mounted file system would be extremely slow ... ${NC}"
    exit 1
fi

~/loadrc/bashrc/run_once_script_checker.sh ~/loadrc/bashrc/do_update_proj.sh
