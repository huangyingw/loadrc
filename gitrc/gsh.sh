#!/bin/zsh
if [ -z "$1" ]
then
    echo -e "${red}please specify the file name ... ${NC}"
    exit 1
fi
commits=( $(git log --oneline --format=%H --follow -- "$1") )
for (( i=0; i<${#commits[@]}; i++ )); do echo ${commits[i]};git difftool -y ${commits[i]}^! "$1"; done
