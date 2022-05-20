#!/bin/sh

git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
    while read path_key path
    do
        name=$(echo $path_key | sed 's/\submodule\.\(.*\)\.path/\1/')
        url_key=$(echo $path_key | sed 's/\.path/.url/')
        branch_key=$(echo $path_key | sed 's/\.path/.branch/')
        url=$(git config -f .gitmodules --get "$url_key")
        branch=$(git config -f .gitmodules --get "$branch_key" || echo "master")
        if [ -d "$path" ] && [ ! $(git config --get "$url_key") ]
        then
            mv "$path" "$path""_backup_""$(date +'%Y%m%d%H%M%S')";
        fi
        git submodule add -b $branch --name $name $url $path || continue
    done
