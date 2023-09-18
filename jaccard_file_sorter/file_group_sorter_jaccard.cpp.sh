#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

#apt-get install -y libspdlog-dev libleveldb-dev libtbb-dev libxxhash-dev 

make && \            
    make install && \
    /usr/local/bin/file_group_sorter_jaccard "/media/fav.log" "/media/fav.log.dup"
