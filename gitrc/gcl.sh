#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide parameter ... ${NC}"
    exit 1
fi

. ~/loadrc/gitrc/parse_github.sh "$1"
target="${author}-${repo}"
echo "target --> $target"

git clone "$1" "$target" ; \
    cp -fv ~/loadrc/.gitconfig_sample "$target"/.gitconfig

urlVar="$1"
urlVar=$(echo "$urlVar" | sed 's/\//\\\//g')
sed -i.bak "s/urlVar/$urlVar/g;s/repoVar/$target/g;s/authorVar/$author/g" "$target"/.gitconfig
echo ".gitconfig --> $(realpath ${target}/.gitconfig)"

cd "$target" \
    && $HOME/loadrc/gitrc/gcob.sh dev \
    && $HOME/loadrc/gitrc/gdev.sh \
    && $HOME/loadrc/bashrc/cscope.sh \
    && git add . \
    && git add -f files.proj .gitconfig \
    && $HOME/loadrc/gitrc/g.sh \
    && hub create \
    && ~/loadrc/gitrc/gclb.sh
