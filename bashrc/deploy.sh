#!/bin/bash -

host=$(git config deploy.host)
path=$(git config deploy.path)
~/loadrc/bashrc/rsync.sh "$host:$path"
