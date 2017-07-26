#!/bin/bash
git config --local include.path $(realpath .gitconfig)
. ~/loadrc/gitrc/getCommit_message.sh "$1"
git commit -am "$commit_message"
~/loadrc/gitrc/postCommit.sh
