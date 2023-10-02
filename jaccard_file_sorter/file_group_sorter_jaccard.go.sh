#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

go mod init github.com/huangyingw/FileSorter
go get -u github.com/go-redis/redis/v8
go get -u github.com/cespare/xxhash/v2

docker run --name file_group_sorter_jaccard -d -p 6380:6379 redis redis-server --appendonly yes

go build file_group_sorter_jaccard.go && \
    ./file_group_sorter_jaccard "/media/115_disk/av/kyler/fav.log" "/media/115_disk/av/kyler/fav.log.dup"
