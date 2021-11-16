#!/bin/zsh

if [ -z "$1" ]
then
    echo -e "${red}Please provide parameter ... ${NC}"
    exit 1
fi

. ~/loadrc/gitrc/parse-github.sh "$1"
target="${author}/${repo}"
echo "target --> $target"

git clone "$1" "$target" ; \
    cp -v ~/loadrc/.gitconfig_sample "$target"/.gitconfig

urlVar="$1"
urlVar=$(echo "$urlVar" | sed 's/\//\\\//g')
sed -i.bak "s|urlVar|$urlVar|g;s|repoVar|${author}_${repo}|g;s|authorVar|$author|g" "$target"/.gitconfig
echo ".gitconfig --> $(realpath ${target}/.gitconfig)"

cd "$target"
CURRENT_BRANCH=$(~/loadrc/gitrc/get_current_branch.sh)
sed -i.bak "s|branchVar|$CURRENT_BRANCH|g" .gitconfig

git remote remove origin ; \
    $HOME/loadrc/gitrc/gcob.sh dev && \
    $HOME/loadrc/gitrc/gdev.sh && \
    $HOME/loadrc/bashrc/do_update_proj.sh && \
    git add . && \
    git add -f files.proj .gitconfig && \
    $HOME/loadrc/gitrc/g.sh && \
    ~/loadrc/gitrc/gclb.sh
