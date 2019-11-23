#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

while read -r line || [[ -n "$line" ]]
do
    cat ~/.ssh/id_rsa.pub | sshpass -p '1qaz@WSX' ssh huangyingw@"$line"  'mkdir -p ~/.ssh/ ; cat >> .ssh/authorized_keys'
done < servers.list

cd -
