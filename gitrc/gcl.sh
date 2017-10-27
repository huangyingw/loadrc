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
        && $HOME/loadrc/bashrc/cscope.sh
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
    sed -i.bak "s/remoteVar/$remote/g" ${target}/.gitconfig
    var="$1"
    var=$(echo "$var" | sed 's/\//\\\//g')
    sed -i.bak "s/urlVar/$var/g" ${target}/.gitconfig

    cd ${target} \
        && $HOME/loadrc/gitrc/gcob.sh dev.fix \
        && $HOME/loadrc/gitrc/gdev.sh \
        && $HOME/loadrc/bashrc/cscope.sh \
        && git add . \
        && $HOME/loadrc/gitrc/gci.sh
fi
