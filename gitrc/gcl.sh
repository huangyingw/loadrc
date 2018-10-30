#!/bin/bash

if [ -z "$1" ]
then
    echo -e "${red}Please provide parameter ... ${NC}"
    exit 1
fi

if [[ "$1" == *"Dropbox"* ]]
then
    target=`echo $1 | sed -e "s|Dropbox/||"`
    echo ${target}
    git clone "$1" "$target" \
        && cd ${target} \
        && $HOME/loadrc/bashrc/update_proj.sh
else
    target=`echo $1 | sed -e "s|.git$||;s|^.*github.com.||"`
    remote=`echo $1 | sed -e "s|.git$||;s|^.*github.com.||;s|\/.*||"`
    if [ -n "$2" ]
    then
        target="$2"
    fi
    mkdir -p ${target}
    echo ${target} \
        && git clone "$1" ${target} \
        && cp -v ~/loadrc/.gitconfig_sample ${target}/.gitconfig
    urlVar="$1"
    projVar=$(echo "$urlVar" | sed 's/.*\///g;s/\.git//g')
    urlVar=$(echo "$urlVar" | sed 's/\//\\\//g')
    sed -i.bak "s/urlVar/$urlVar/g;s/projVar/$projVar/g" ${target}/.gitconfig

    cd ${target} \
        && $HOME/loadrc/gitrc/gcob.sh dev \
        && $HOME/loadrc/gitrc/gdev.sh \
        && $HOME/loadrc/bashrc/cscope.sh \
        && git add . \
        && git add -f files.proj \
        && $HOME/loadrc/gitrc/g.sh \
        && ~/loadrc/gitrc/gclb.sh
fi
